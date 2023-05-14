import 'package:sonic_mobile/models/models.dart';

// AlbumState class represents the different states of the album feature
abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Song> songs;

  AlbumLoaded(this.songs);

  get album => null;
}

class AlbumError extends AlbumState {
  final String errorMessage;

  AlbumError(this.errorMessage);
}