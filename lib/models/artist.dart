import 'package:sonic_mobile/models/models.dart';

class Artist {
  final String id;
  final String name;
  final String picture;
  final List<AlbumInfo> albums;

  Artist(
      {required this.id,
      required this.name,
      required this.picture,
      required this.albums});

  factory Artist.fromJson(Map<String, dynamic> json) {
    List<AlbumInfo> albums = [];
    for (var album in json["albums"]) {
      albums.add(AlbumInfo.fromJson(album));
    }
    return Artist(
        id: json["id"].toString(),
        name: json["name"],
        picture: json["picture"],
        albums: albums);
  }

  // Map<String, dynamic> toJson(Artist artist) {
  //   return {
  //     "name": artist.name,
  //     "picture": artist.picture,
  //   };
  // }
}
