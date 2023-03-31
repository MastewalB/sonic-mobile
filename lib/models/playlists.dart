import 'models.dart';

class Playlist {
  final String id;
  final User createdBy;
  final String playlistTitle;
  final List<Song> items;

  Playlist({
    required this.id,
    required this.createdBy,
    required this.playlistTitle,
    required this.items,
  });
}
