import 'package:http/http.dart' as http;
import 'package:sonic_mobile/core/core.dart';
import 'dart:convert';

// import 'package:sonic_mobile/models/album.dart';
import 'package:sonic_mobile/models/models.dart';

class RecommendationDataProvider {
  final _baseUrl = Constants.apiUrl;
  final http.Client httpClient;

  RecommendationDataProvider({required this.httpClient});

  // get album by id
  Future<List<Song>> getRecommendation(String songId) async {
    final response =
    await httpClient.get(Uri.parse('${_baseUrl}recommender/recommend/$songId/'));
    // print(response.statusCode);
    // print(albumId);
    if (response.statusCode == 200) {
      final List<dynamic> recommendation = jsonDecode(response.body);
      // print("here success");
      return recommendation.map((songData) => Song.fromJson(songData)).toList();
    } else {
      throw Exception('Failed to load recommendation');
    }
  }

  //get songs
  // Future<List<Song>> getSongs(Album album) async {
  //   final response = await httpClient.get(Uri.parse('${_baseUrl}songs/'));
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> songs = jsonDecode(response.body);
  //     return songs.map((songData) => Song.fromJson(songData)).toList();
  //   } else {
  //     throw Exception('Failed to load songs');
  //   }
  // }
// get albums by artist id
}
