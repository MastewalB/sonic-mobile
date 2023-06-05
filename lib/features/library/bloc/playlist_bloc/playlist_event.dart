part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();
}

class CreatePlaylistEvent extends PlaylistEvent {
  final String playlistTitle;

  const CreatePlaylistEvent({
    required this.playlistTitle,
  });

  @override
  List<Object?> get props => [];
}

class GetPlaylistsByUserEvent extends PlaylistEvent {
  @override
  List<Object?> get props => [];
}

class AddItemEvent extends PlaylistEvent {
  final String playlistId;
  final String songId;

  @override
  List<Object?> get props => [];

  const AddItemEvent({
    required this.playlistId,
    required this.songId,
  });
}

class RemoveItemEvent extends PlaylistEvent {
  final String playlistId;
  final String songId;

  @override
  List<Object?> get props => [];

  const RemoveItemEvent({
    required this.playlistId,
    required this.songId,
  });
}

class DeletePlaylistEvent extends PlaylistEvent {
  final String playlistId;

  @override
  List<Object?> get props => [];

  const DeletePlaylistEvent({
    required this.playlistId,
  });
}

class GetPlaylistDetailEvent extends PlaylistEvent {
  final String playlistId;

  const GetPlaylistDetailEvent({
    required this.playlistId,
  });

  @override
  List<Object?> get props => [];
}
