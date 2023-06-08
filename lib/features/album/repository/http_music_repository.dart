import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:sonic_mobile/models/album.dart';
import 'package:sonic_mobile/models/models.dart';

class AlbumDataProvider {
  final _baseUrl = 'http://localhost:8000/api/v1/music';
  final http.Client httpClient;

  AlbumDataProvider({required this.httpClient});

  // get album by id
  Future<Album> getAlbum(String albumId) async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/albums/$albumId/'));
    print(response.statusCode);
    // print(albumId);
    if (response.statusCode == 200) {
      final album = jsonDecode(response.body);
      print("here success");
      return Album.fromJson(album);
    } else {
      throw Exception('Failed to load album');
    }
  }

  // get all albums
  Future<Album> getAllAlbums() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/albums/'));

    if (response.statusCode == 200) {
      final albums = jsonDecode(response.body);
      return Album.fromJson(albums);
    } else {
      throw Exception('Failed to load album');
    }
  }

  //get songs
  Future<List<Song>> getSongs(Album album) async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/songs/'));

    if (response.statusCode == 200) {
      final List<dynamic> songs = jsonDecode(response.body);
      return songs.map((songData) => Song.fromJson(songData)).toList();
    } else {
      throw Exception('Failed to load songs');
    }
  }
  // get albums by artist id
}

class ArtistDataProvider {
  final _baseUrl = 'http://localhost:8000/api/v1/music/';
  final http.Client httpClient;

  ArtistDataProvider({required this.httpClient});

  // get artist by id
  Future<Artist> getArtist(String artistId) async {
    final response =
        await httpClient.get(Uri.parse('$_baseUrl/artists/$artistId'));

    if (response.statusCode == 200) {
      final artist = jsonDecode(response.body);
      return Artist.fromJson(artist);
    } else {
      throw Exception('Failed to load artist');
    }
  }

  // get all artists
  Future<Artist> getAllArtists() async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/artists/'));

    if (response.statusCode == 200) {
      final artist = jsonDecode(response.body);
      return Artist.fromJson(artist);
    } else {
      throw Exception('Failed to load aritst');
    }
  }
}
