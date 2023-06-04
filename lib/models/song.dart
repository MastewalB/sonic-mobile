import 'package:sonic_mobile/models/models.dart';

class Song implements Audio {
  final String id;
  @override
  final String title;
  final Artist artist;
  final Album album;
  final String songFile;
  final String contentType;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.songFile,
    required this.contentType,
  });

  @override
  String get artistName => artist.name;

  @override
  String get fileUrl => songFile;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json["id"],
      title: json["title"],
      artist: json["s_artist"],
      album: json["s_album"],
      songFile: json["song_file"],
      contentType: json["content_type"],
    );
  }

  Map<String, dynamic> toJson(Song song) {
    return {
      "title": song.title,
      "s_artist": song.artist,
      "s_album": song.album,
      "song_file": song.songFile,
      "content_type": song.contentType
    };
  }
}
