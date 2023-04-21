import 'package:sonic_mobile/models/models.dart';

class Album {
  final String id;
  final Artist artist;
  final String name;
  final String cover;

  Album({
    required this.id,
    required this.artist,
    required this.name,
    required this.cover,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json["id"],
      artist: json["artist"],
      name: json["name"],
      cover: json["cover"],
    );
  }

  Map<String, dynamic> toJson(Album album) {
    return {
      "artist": album.artist,
      "name": album.name,
      "cover": album.cover,
    };
  }
}
