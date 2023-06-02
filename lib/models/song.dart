import 'package:sonic_mobile/models/models.dart';

class Song implements Audio {
  final String id;
  @override
  final String title;
  final Artist artist;
  final AlbumInfo album;
  final String songFile;
  final String contentType;
  // final DateTime dateAdded;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.songFile,
    required this.contentType,
    // required this.dateAdded
  });

  @override
  String get artistName => artist.name;

  @override
  String get fileUrl => songFile;

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json["id"].toString(),
      title: json["title"],
      artist: Artist.fromJson(json["s_artist"]),
      album: AlbumInfo.fromJson(json["s_album"]),
      songFile: json["song_file"],
      contentType: json["content_type"],
      // dateAdded: json["dateAdded"],
    );
  }

  Map<String, dynamic> toJson(Song song) {
    return {
      "title": song.title,
      "s_artist": song.artist,
      "s_album": song.album,
      "song_file": song.songFile,
      "content_type": song.contentType,
      // "dateAdded": song.dateAdded
    };
  }
}
