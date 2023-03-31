import 'package:sonic_mobile/models/models.dart';

class Artist {
  final String name;
  final String picture;

  Artist({required this.name, required this.picture});
}

class Album {
  final Artist artist;
  final String name;
  final String cover;

  Album({required this.artist, required this.name, required this.cover});
}

class Song implements Audio{
  @override
  final String title;

  final Artist artist;
  final Album album;
  final String songFile;
  final String contentType;

  Song(
      {required this.title,
      required this.artist,
      required this.album,
      required this.songFile,
      required this.contentType});
}
