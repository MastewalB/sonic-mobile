import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/studio_podcast.dart';

class HttpStudioRepository implements StudioRepository {
  final String apiUrl = "http://127.0.0.1:8000/api/v1/studio";
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgyMTk5NjYzLCJpYXQiOjE2ODIxOTYwNjMsImp0aSI6ImIyZTM1ODhiMWMwMjQ5ODhiN2ExOGMxMDc0MzhkOGMxIiwidXNlcl9pZCI6IjE4MjRjYTY0LTAwMmQtNGU5Mi04MjJlLTZkMDBhYmNmYTUyNCIsIlRPS0VOX1RZUEVfQ0xBSU0iOiJhY2Nlc3MifQ.nNLo-U-CnTp8bhPIsXdvEcx1zFUF2iFfdukvHQLFp14";
  final http.Client httpClient;

  const HttpStudioRepository({
    required this.httpClient,
  });


  @override
  Future<StudioPodcast> createPodcast(
      String title, String description, String genre) async {
    Uri uri = Uri.parse("$apiUrl/podcasts/");

    var body = json
        .encode({"title": title, "description": description, "genre": genre});
    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      if (response.statusCode >= 400) {
        throw Exception("No");
      }
      print(response.body);
      return StudioPodcast.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deletePodcast(String podcastId) async {
    // TODO: implement deletePodcast
    throw UnimplementedError();
  }

  @override
  Future<StudioPodcast> getPodcastDetail(String podcastId) async {
    // TODO: implement getPodcastDetail
    throw UnimplementedError();
  }

  @override
  Future<List<StudioPodcast>> getPodcastsByUser(String userId) async {
    String id = "1824ca64-002d-4e92-822e-6d00abcfa524";
    Uri uri = Uri.parse("$apiUrl/podcasts/list/$id");

    try {
      final response = await httpClient.get(uri);
      if (response.statusCode >= 400) {
        throw Exception("No");
      }
      var data = json.decode(response.body);
      List<StudioPodcast> allPodcasts = [];

      for (var podcast in data) {
        allPodcasts.add(StudioPodcast.fromJson(podcast));
      }
      return allPodcasts;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<StudioPodcast> updatePodcast(
      String? title, String? description, String? genre) async {
    // TODO: implement updatePodcast
    throw UnimplementedError();
  }


}
