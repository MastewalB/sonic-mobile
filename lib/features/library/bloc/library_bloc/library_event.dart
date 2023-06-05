part of 'library_bloc.dart';

abstract class LibraryEvent extends Equatable {
  const LibraryEvent();
}

class GetAllPlaylistsByUser extends LibraryEvent {
  @override
  List<Object?> get props => [];
}

class CreatePlaylistEvent extends LibraryEvent {
  final String playlistTitle;

  const CreatePlaylistEvent({
    required this.playlistTitle,
  });

  @override
  List<Object?> get props => [];
}