import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'package:audioplayers/audioplayers.dart';
import 'package:sonic_mobile/core/core.dart';

// import 'package:just_audio/just_audio.dart' as Just;
import 'package:sonic_mobile/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:sonic_mobile/features/auth/models/user_profile.dart';

part 'audio_player_event.dart';

part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer;
  final UserProfileRepository userProfileRepository;
  WebSocketChannel channel;
  bool isStreamOwner = false;

  int currentIndex = 0;
  bool isPlaying = false;
  bool isLooping = false;

  ListQueue<Audio> audioQueue = ListQueue<Audio>();

  void initialize() async {}

  AudioPlayerBloc({
    required this.audioPlayer,
    required this.userProfileRepository,
    required this.channel,
  }) : super(AudioPlayerState(audioPlayer: audioPlayer, isLooping: false)) {
    AudioPlayer.logEnabled = false;

    state.audioPlayer.onPlayerCompletion.listen((event) async {
      if (isStreamOwner) {
        if (isLooping) {
          await state.audioPlayer.setUrl(
            audioQueue.elementAt(currentIndex).fileUrl,
          );
          add(PlayAudioEvent(
            currentIndex: currentIndex,
            fromCurrentPlaylist: true,
          ));
        } else {
          add(PlayNextEvent());
        }
      }
    });

    state.audioPlayer.onPlayerError.listen((event) {
      add(AudioPlayerFailedEvent(errorMessage: event.toString()));
    });

    channel.stream.listen((data) async {
      final UserProfile userProfile = await userProfileRepository.getUser();
      var jsonData = json.decode(data);

      if (jsonData["SENDER"] != userProfile.id) {
        String msgType = jsonData["MSG_TYPE"];
        switch (msgType) {
          case "STATUS_REQ":
            // if (isStreamOwner) {
            int currentPosition = await state.audioPlayer.getCurrentPosition();
            Audio audio = state.audioQueue!.elementAt(state.currentIndex);
            sendMessage("STATUS_UPDATE", "PLAY", audio, currentPosition, true);
            // }
            return;
          case "STATUS_UPDATE":
            switch (jsonData["OPERATION"]) {
              case "PLAY":
                String url = jsonData["DATA"]["URL"];
                String artistName = jsonData["DATA"]["ARTIST_NAME"];
                String title = jsonData["DATA"]["TITLE"];
                String imageUrl = jsonData["DATA"]["IMAGE_URL"];
                ListQueue<Audio> playlist = ListQueue<Audio>(0);

                //Load the information to the audio player state
                // await state.audioPlayer
                //     .setUrl(audioQueue.elementAt(currentIndex).fileUrl);

                //start playing the audio
                playlist.add(Audio(
                  fileUrl: url,
                  artistName: artistName,
                  title: title,
                  imageUrl: imageUrl,
                ));
                // audioQueue = playlist;
                currentIndex = 0;
                // add(AudioPlayerLoadingEvent());
                add(
                  PlayAudioEvent(
                    playlist: playlist,
                    fromCurrentPlaylist: false,
                    currentIndex: currentIndex,
                  ),
                );
                // if (jsonData["DATA"]["PLAY"]) {
                //   add(
                //     PlayAudioEvent(
                //         playlist: playlist,
                //         fromCurrentPlaylist: false,
                //         currentIndex: 0),
                //   );
                // }
                break;
              case "PAUSE":
                add(PauseAudioEvent());
                break;
              case "RESUME":
                add(ResumeAudioEvent());
                break;
              case "SEEK":
                int seekSeconds = jsonData['DATA']['SEEK'];
                add(SeekAudioEvent(
                    newPosition: Duration(seconds: seekSeconds)));
                break;
            }
        }
      }
    });

    initialize();

    on<AudioPlayerLoadingEvent>((event, emit) async {
      emit(state.copyWith(
        audioPlayer: audioPlayer,
        currentIndex: currentIndex,
        status: AudioPlayerStatus.loading,
      ));
    });

    on<PlayAudioEvent>((event, emit) async {
      if (!event.fromCurrentPlaylist) {
        if (event.playlist == null) {
          emit(state.copyWith(
            audioPlayer: audioPlayer,
            isPlaying: false,
            status: AudioPlayerStatus.failure,
          ));
          return;
        }

        audioQueue.clear();
        audioQueue = event.playlist!;
      }

      currentIndex = event.currentIndex ?? 0;

      emit(state.copyWith(
        audioPlayer: audioPlayer,
        isPlaying: true,
        currentIndex: currentIndex,
        status: AudioPlayerStatus.loading,
        audioQueue: audioQueue,
      ));

      isPlaying = true;
      await state.audioPlayer.stop();

      emit(state.copyWith(
        status: AudioPlayerStatus.playing,
        isPlaying: true,
        currentIndex: currentIndex,
        audioQueue: audioQueue,
      ));
      // String url = audioQueue.elementAt(currentIndex).fileUrl;
      // String urlw = "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Timelapse%20.mp3";
      // print(url);
      // final player = Just.AudioPlayer();
      // await player.setUrl(url);
      // await player.play();
      // await state.audioPlayer.setUrl(url);

      //send message to the group streaming interface
      sendMessage("STATUS_UPDATE", "PLAY",
          audioQueue.elementAt(currentIndex), null, true);
      // ! ------ !

      await state.audioPlayer.play(
        audioQueue.elementAt(currentIndex).fileUrl,
        isLocal: event.isLocal,
      );
    });

    on<ResumeAudioEvent>((event, emit) async {
      //send message to the group streaming interface
      sendMessage("STATUS_UPDATE", "RESUME", null, null, true);
      // ! ------ !

      await state.audioPlayer.resume();
      emit(state.copyWith(status: AudioPlayerStatus.playing));
    });

    on<PauseAudioEvent>((event, emit) async {
      //send message to the group streaming interface
      sendMessage("STATUS_UPDATE", "PAUSE", null, null, true);
      // ! ------ !

      await state.audioPlayer.pause();
      emit(state.copyWith(
        status: AudioPlayerStatus.paused,
      ));
    });

    on<StopAudioEvent>((event, emit) async {
      //send message to the group streaming interface
      isStreamOwner = false;
      disconnect();
      // ! ------ !

      isPlaying = false;
      currentIndex = 0;
      await state.audioPlayer.stop();
      emit(state.copyWith(isPlaying: false, currentIndex: currentIndex));
    });

    on<PlayNextEvent>((event, emit) async {
      currentIndex++;
      if (currentIndex >= audioQueue.length) {
        currentIndex = 0;
      }
      await state.audioPlayer.stop();

      AudioPlayerStatus prevState = state.status;
      emit(state.copyWith(
        audioPlayer: audioPlayer,
        currentIndex: currentIndex,
        status: AudioPlayerStatus.loading,
      ));

      await state.audioPlayer
          .setUrl(audioQueue.elementAt(currentIndex).fileUrl);
      if (prevState == AudioPlayerStatus.playing) {
        add(PlayAudioEvent(
          currentIndex: currentIndex,
          fromCurrentPlaylist: true,
        ));
      } else {
        //send message to the group streaming interface
        sendMessage("STATUS_UPDATE", "PLAY",
            state.audioQueue!.elementAt(state.currentIndex), null, false);
        // ! ------ !

        emit(state.copyWith(
          audioPlayer: audioPlayer,
          currentIndex: currentIndex,
          status: AudioPlayerStatus.paused,
        ));
      }
    });

    on<PlayPreviousEvent>((event, emit) async {
      if (await state.audioPlayer.getCurrentPosition() < 5000) {
        currentIndex--;
      }
      if (currentIndex < 0) {
        currentIndex = audioQueue.length - 1;
      }
      await state.audioPlayer.stop();

      AudioPlayerStatus prevState = state.status;
      emit(state.copyWith(
        audioPlayer: audioPlayer,
        currentIndex: currentIndex,
        status: AudioPlayerStatus.loading,
      ));

      await state.audioPlayer
          .setUrl(audioQueue.elementAt(currentIndex).fileUrl);
      if (prevState == AudioPlayerStatus.playing) {
        add(PlayAudioEvent(
          currentIndex: currentIndex,
          fromCurrentPlaylist: true,
        ));
      } else {
        //send message to the group streaming interface
        sendMessage("STATUS_UPDATE", "PLAY",
            state.audioQueue!.elementAt(state.currentIndex), null, false);
        // ! ------ !

        emit(state.copyWith(
          audioPlayer: audioPlayer,
          currentIndex: currentIndex,
          status: AudioPlayerStatus.paused,
        ));
      }
    });

    on<SeekAudioEvent>((event, emit) async {
      await state.audioPlayer.seek(event.newPosition);

      //send message to the group streaming interface
      sendMessage(
        "STATUS_UPDATE",
        "SEEK",
        state.audioQueue!.elementAt(state.currentIndex),
        event.newPosition.inSeconds,
        false,
      );
      // ! ------ !
    });

    on<ToggleLoopEvent>((event, emit) async {
      isLooping = !isLooping;
      emit(state.copyWith(
        audioPlayer: audioPlayer,
        isLooping: isLooping,
      ));
    });

    on<AudioPlayerFailedEvent>((event, emit) async {
      emit(state.copyWith(
        status: AudioPlayerStatus.failure,
        isPlaying: false,
      ));
    });
  }

  Stream<Duration> currentPosition() async* {
    yield* audioPlayer.onAudioPositionChanged;
  }

  Stream<Duration> fileDuration() async* {
    yield* audioPlayer.onDurationChanged;
  }

  //Channel Stuff
  set setChannel(WebSocketChannel newChannel) {
    channel = newChannel;
  }

  void connect(String? sId) async {
    UserProfile userProfile = await userProfileRepository.getUser();
    String streamId = sId ?? userProfile.id;
    String connectUrl = Constants.connectStreamUrl;
    WebSocketChannel connection =
        WebSocketChannel.connect(Uri.parse("$connectUrl$streamId/"));
    channel = connection;
    if (userProfile.id == streamId) {
      isStreamOwner = true;
    } else {
      sendMessage(
        "STATUS_REQ",
        null,
        null,
        null,
        null,
      );
    }
  }

  void disconnect() async {
    UserProfile userProfile = await userProfileRepository.getUser();
    channel = WebSocketChannel.connect(
        Uri.parse("${Constants.connectStreamUrl}${userProfile.id}/"));
  }

  void sendMessage(String msgType, String? operation, Audio? audio,
      int? seconds, bool? startPlaying) async {
    final UserProfile userProfile = await userProfileRepository.getUser();
    var body = json.encode({
      "OWNER": (isStreamOwner) ? userProfile.id : null,
      "SENDER": userProfile.id,
      "MSG_TYPE": msgType,
      "OPERATION": operation,
      "DATA": {
        "URL": audio?.fileUrl,
        "ARTIST_NAME": audio?.artistName,
        "TITLE": audio?.title,
        "IMAGE_URL": audio?.imageUrl,
        "PLAY": startPlaying,
        "SEEK": seconds
      }
    });
    channel.sink.add(body);
  }
}
