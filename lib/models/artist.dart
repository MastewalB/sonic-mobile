import 'package:sonic_mobile/models/models.dart';

class Artist {
  final String id;
  final String name;
  final String picture;

  Artist({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json["id"].toString(),
      name: json["name"],
      picture: json["picture"],
    );
  }

  Map<String, dynamic> toJson(Artist artist) {
    return {
      "name": artist.name,
      "picture": artist.picture,
    };
  }
}
