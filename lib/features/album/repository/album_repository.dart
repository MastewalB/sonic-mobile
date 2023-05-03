import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sonic_mobile/models/models.dart';

class AlbumDataProvider {
  final String apiUrl = 'http://127.0.0.1:8000/api/v1/music/albums/';

//   Future<List<Song>> getSongsForAlbum(Album album) async {
//     final response = await http.get('$api Url/${album.id}/');
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data.map((songData) => Song.fromJson(songData)).toList();
//     } else {
//       throw Exception('Failed to fetch songs');
//     }
//   }
}
