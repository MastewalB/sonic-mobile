part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoadedState extends AlbumState {
  final List<Album> albums;

  AlbumLoadedState(this.albums);
}

class AlbumErrorState extends AlbumState {
  final String message;

  AlbumErrorState(this.message);

  @override
  List<Object> get props => [message];
}
