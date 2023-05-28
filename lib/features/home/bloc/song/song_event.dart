import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/models/song.dart';

abstract class SongState extends Equatable {
  const SongState();

  @override
  List<Object> get props => [];
}

class SongLoadingState extends SongState {}

class SongLoadedState extends SongState {
  final List<Song> songs;

  const SongLoadedState(this.songs);

  @override
  List<Object> get props => [songs];
}

class SongErrorState extends SongState {
  final String message;

  const SongErrorState(this.message);

  @override
  List<Object> get props => [message];
}
