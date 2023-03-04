import 'dart:async';
import 'dart:collection';
import 'package:audioplayers/audioplayers.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_player_event.dart';

part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer;
  int currentIndex = 0;
  bool isPlaying = false;
  bool finishedQueue = false;

  ListQueue<AudioMock> audioQueue = //ListQueue<AudioMock>(0);
      ListQueue<AudioMock>.from([
    const AudioMock(
      id: "id",
      language: "language",
      description: "Little Sunshine - But Solo",
      category: "Family",
      type: "type",
      thumbnail:
          "https://images.ecestaticos.com/xnNbBZp8-d8EtrRzQNEnUp3hOL4=/0x60:1919x1138/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fcc3%2F6d5%2F5eb%2Fcc36d55ebd0a8c375b6530ab68b0252b.jpg",
      audio: "audio",
      audioUrl:
          "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Little%20Sunshine%20-%20Solo.mp3",
    ),
    const AudioMock(
      id: "id2",
      language: "language",
      description: "Little Sunshine",
      category: "Family",
      type: "type",
      thumbnail:
          "https://www.hdwallpapers.in/download/life_2017_movie_4k-wide.jpg",
      audio: "audio",
      audioUrl:
          "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Little%20Sunshine.mp3",
    )
  ]);

  AudioPlayerBloc({required this.audioPlayer})
      : super(AudioPlayerState(audioPlayer: audioPlayer)) {
    AudioPlayer.logEnabled = false;
    state.audioPlayer.onPlayerCompletion.listen((event) {
      add(PlayNextEvent());
    });

    state.audioPlayer.onPlayerError.listen((event) {
      add(AudioPlayerFailedEvent(errorMessage: event.toString()));
    });

    // on<AudioPlayerEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<PlayAudioEvent>((event, emit) async {
      print("Current Index . . . " + currentIndex.toString());
      emit(state.copyWith(
        audioPlayer: audioPlayer,
        status: AudioPlayerStatus.loading,
      ));
      //Check if already playing another content
      isPlaying = true;

      // Clear the current queue as the new song will insert its queue
      // audioQueue.clear();

      //TODO - Populate the audio queue with the audio files in the selected category.
      //For now let's just add the given audio only.
      audioQueue.add(event.audio);
      print("Current Len . . . " + audioQueue.length.toString());
      // await state.audioPlayer.stop();

      // await state.audioPlayer.play(event.audio.audioUrl, stayAwake: true);
      // TODO - Find the current index of the audio in the queue.
      // currentIndex = audioQueue
      //await state.audioPlayer.play(audioQueue.elementAt(currentIndex).audioUrl, stayAwake: true);

      // state.audioPlayer.setNotification();
      emit(state.copyWith(
          status: AudioPlayerStatus.playing,
          isPlaying: true,
          currentIndex: currentIndex,
          audioQueue: audioQueue));
      await state.audioPlayer.play(audioQueue.elementAt(currentIndex).audioUrl);
      print("Playinggggggggggggggggggggggggggggggggggggg");
    });

    on<PauseAudioEvent>((event, emit) async {
      print("pauseeee");
      isPlaying = false;
      await state.audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
      print(state.status);
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
      await state.audioPlayer
          .setUrl(audioQueue.elementAt(currentIndex).audioUrl);
      if (isPlaying) {
        add(PlayAudioEvent(audio: audioQueue.elementAt(currentIndex)));
      }
      emit(state.copyWith(
        currentIndex: currentIndex,
      ));
    });

    on<PlayPreviousEvent>((event, emit) async {
      currentIndex--;
      if (currentIndex < 0) {
        currentIndex = audioQueue.length - 1;
      }
      await state.audioPlayer.stop();
      await state.audioPlayer
          .setUrl(audioQueue.elementAt(currentIndex).audioUrl);
      if (isPlaying) {
        add(PlayAudioEvent(audio: audioQueue.elementAt(currentIndex)));
      }
      emit(state.copyWith(
        currentIndex: currentIndex,
      ));
    });

    on<SeekAudioEvent>((event, emit) async {
      await state.audioPlayer.seek(event.newPosition);
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
