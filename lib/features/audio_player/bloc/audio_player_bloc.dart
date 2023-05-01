import 'dart:async';
import 'dart:collection';
import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart' as Just;
import 'package:sonic_mobile/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_player_event.dart';

part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer;
  int currentIndex = 0;
  bool isPlaying = false;
  bool isLooping = false;

  ListQueue<Audio> audioQueue = ListQueue<Audio>();

  AudioPlayerBloc({required this.audioPlayer})
      : super(AudioPlayerState(audioPlayer: audioPlayer, isLooping: false)) {
    AudioPlayer.logEnabled = false;

    state.audioPlayer.onPlayerCompletion.listen((event) async {
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
    });

    state.audioPlayer.onPlayerError.listen((event) {
      add(AudioPlayerFailedEvent(errorMessage: event.toString()));
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
      String url = audioQueue.elementAt(currentIndex).fileUrl;
      // String urlw = "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Timelapse%20.mp3";
      // print(url);
      // final player = Just.AudioPlayer();
      // await player.setUrl(url);
      // await player.play();
      // await state.audioPlayer.setUrl(url);
      await state.audioPlayer.play(audioQueue.elementAt(currentIndex).fileUrl);
    });

    on<ResumeAudioEvent>((event, emit) async {
      await state.audioPlayer.resume();
      emit(state.copyWith(status: AudioPlayerStatus.playing));
    });

    on<PauseAudioEvent>((event, emit) async {
      await state.audioPlayer.pause();
      emit(state.copyWith(
        status: AudioPlayerStatus.paused,
      ));
    });

    on<StopAudioEvent>((event, emit) async {
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
        emit(state.copyWith(
          audioPlayer: audioPlayer,
          currentIndex: currentIndex,
          status: AudioPlayerStatus.paused,
        ));
      }
    });

    on<PlayPreviousEvent>((event, emit) async {
      currentIndex--;
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
        emit(state.copyWith(
          audioPlayer: audioPlayer,
          currentIndex: currentIndex,
          status: AudioPlayerStatus.paused,
        ));
      }
    });

    on<SeekAudioEvent>((event, emit) async {
      await state.audioPlayer.seek(event.newPosition);
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
}
