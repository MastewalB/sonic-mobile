import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sonic_mobile/models/album.dart';

class AlbumDataProvider {
  final _baseUrl = 'http://localhost:8000/api/v1/music/albums';
  final http.Client httpClient;

  AlbumDataProvider({required this.httpClient});

  // get album by id
  Future<Album> getAlbum(String albumId) async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/$albumId'));

    if (response.statusCode == 200) {
      final album = jsonDecode(response.body);
      return Album.fromJson(album);
    } else {
      throw Exception('Failed to load album');
    }
  }

  // get all albums
  // to do
}
