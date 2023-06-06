import 'package:sonic_mobile/models/models.dart';

class Album {
  final String id;
  final Artist artist;
  final String name;
  final String cover;
  final List<Song> songs;

  Album(
      {required this.id,
      required this.artist,
      required this.name,
      required this.cover,
      required this.songs});

  factory Album.fromJson(Map<String, dynamic> json) {
    List<Song> songs = [];
    for (var song in json["songs"]) {
      songs.add(Song.fromJson(song));
      // print(song);
    }
    return Album(
      id: json["id"].toString(),
      artist: Artist.fromJson(json["artist"]),
      name: json["name"],
      cover: json["cover"],
      songs: songs,
    );
  }
}

class AlbumInfo {
  final String id;
  final String name;
  final String cover;

  AlbumInfo({
    required this.id,
    required this.name,
    required this.cover,
  });

  factory AlbumInfo.fromJson(Map<String, dynamic> json) {
    return AlbumInfo(
      id: json["id"].toString(),
      name: json["name"],
      cover: json["cover"],
    );
  }
}
