import 'users.dart';
import 'music.dart';

class Playlist {
  final String id;
  final User createdBy;
  final String playlistTitle;

  Playlist(
      {required this.id, required this.createdBy, required this.playlistTitle});
}

class PlaylistItems {
  final Playlist playlistId;
  final Song songId;

  PlaylistItems({required this.playlistId, required this.songId});
}
