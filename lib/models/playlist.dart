import 'models.dart';

class Playlist implements AudioList {
  final String id;
  final User createdBy;
  final String playlistTitle;
  final List<Song> playlistItems;

  @override
  String get audioListTitle => playlistTitle;

  @override
  List<Song> get audioListItems => playlistItems;

  Playlist({
    required this.id,
    required this.createdBy,
    required this.playlistTitle,
    required this.playlistItems,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      createdBy: User.fromJson(json['created_by']),
      playlistTitle: json['playlist_title'],
      playlistItems: json['items']
    );
  }
}
