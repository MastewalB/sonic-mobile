part of 'audio_player_bloc.dart';

enum AudioPlayerStatus { initial, loading, playing, paused, failure }

extension AudioPlayerStatusX on AudioPlayerStatus {
  bool get isInitial => this == AudioPlayerStatus.initial;

  bool get isLoading => this == AudioPlayerStatus.loading;

  bool get isPlaying => this == AudioPlayerStatus.playing;

  bool get isPaused => this == AudioPlayerStatus.paused;

  bool get isFailure => this == AudioPlayerStatus.failure;
}

class AudioPlayerState extends Equatable {
  final AudioPlayer audioPlayer;
  final AudioPlayerStatus status;
  bool isPlaying;
  final bool isLooping;
  int currentIndex;
  bool finishedQueue;
  ListQueue<AudioMock>? audioQueue;

  AudioPlayerState({
    required this.audioPlayer,
    required this.isLooping,
    this.status = AudioPlayerStatus.initial,
    this.isPlaying = false,
    this.currentIndex = 0,
    this.finishedQueue = false,
    audioQueue,
  }) : audioQueue = audioQueue ?? ListQueue<AudioMock>(0);

  @override
  List<Object?> get props =>
      [status, isPlaying, isLooping, currentIndex, finishedQueue];

  AudioPlayerState copyWith(
      {AudioPlayer? audioPlayer,
      AudioPlayerStatus? status,
      bool? isLooping,
      bool? isPlaying,
      int? currentIndex,
      bool? finishedQueue,
      ListQueue<AudioMock>? audioQueue}) {
    return AudioPlayerState(
        audioPlayer: audioPlayer ?? this.audioPlayer,
        isLooping: isLooping ?? this.isLooping,
        status: status ?? this.status,
        isPlaying: isPlaying ?? this.isPlaying,
        currentIndex: currentIndex ?? this.currentIndex,
        finishedQueue: finishedQueue ?? this.finishedQueue,
        audioQueue: audioQueue ?? this.audioQueue);
  }
}

// class AudioPlayerStatus {
//   bool isPlaying;
//   AudioMock currentAudio;
//   int currentIndex;
//   bool finishedQueue;
//
//   AudioPlayerStatus({
//     required this.isPlaying,
//     required this.currentAudio,
//     required this.currentIndex,
//     required this.finishedQueue,
//   });
// }
//
// abstract class AudioPlayerState extends Equatable {
//   AudioPlayer player;
//   ListQueue<Material> audioQueue;
//   AudioPlayerStatus status;
//
//   AudioPlayerState({
//     required this.player,
//     required this.audioQueue,
//     required this.status,
//   });
// }
//
// class AudioPlayerInitial extends AudioPlayerState {
//   AudioPlayerInitial(
//       {required AudioPlayer player,
//       required ListQueue<Material> audioQueue = [],
//       required AudioPlayerStatus status})
//       : audioQueue = audioQueue,
//         super(player: player, audioQueue: audioQueue, status: status);
//
//   @override
//   List<Object> get props => [];
// }
//
// class AudioPlayerLoading extends AudioPlayerState {
//   AudioPlayerLoading(AudioPlayer player, ListQueue<Material> audioQueue,
//       AudioPlayerStatus status)
//       : super(player: player, audioQueue: audioQueue, status: status);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [];
// }
