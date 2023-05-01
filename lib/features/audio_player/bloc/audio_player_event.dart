part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
}

class AudioPlayerFailedEvent extends AudioPlayerEvent {
  final String errorMessage;

  const AudioPlayerFailedEvent({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class PlayAudioEvent extends AudioPlayerEvent {
  ListQueue<Audio>? playlist;
  int? currentIndex;
  bool fromCurrentPlaylist;

  PlayAudioEvent({
    this.playlist,
    this.currentIndex,
    this.fromCurrentPlaylist = false,
  });

  @override
  List<Object?> get props => [];
}

class ResumeAudioEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PauseAudioEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class StopAudioEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PlayNextEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class PlayPreviousEvent extends AudioPlayerEvent {
  @override
  List<Object?> get props => [];
}

class SeekAudioEvent extends AudioPlayerEvent {
  final Duration newPosition;

  SeekAudioEvent({required this.newPosition});

  @override
  List<Object?> get props => [];
}

class ToggleLoopEvent extends AudioPlayerEvent {
  const ToggleLoopEvent();

  @override
  List<Object?> get props => [];
}
