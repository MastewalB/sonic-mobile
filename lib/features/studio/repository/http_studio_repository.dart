import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/studio_podcast.dart';
import 'package:sonic_mobile/core/core.dart';

class HttpStudioRepository implements StudioRepository {
  final String apiUrl = "http://127.0.0.1:8000/api/v1/studio";
  final String token = "";
  final http.Client httpClient;

  const HttpStudioRepository({
    required this.httpClient,
  });

  @override
  Future<StudioPodcast> createPodcast(
      String title, String description, String genre) async {
    Uri uri = Uri.parse("$apiUrl/podcasts/");

    var body = json.encode({
      "title": title,
      "description": description,
      "genre": genre,
    });
    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      return StudioPodcast.fromJson(json.decode(response.body));
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<void> deletePodcast(String podcastId) async {
    Uri uri = Uri.parse("$apiUrl/podcasts/");

    var body = json.encode({
      "id": podcastId,
    });
    try {
      final response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      return;
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
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
      // print(response.body);
      var data = json.decode(response.body);
      // print(data);
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
      String id, String title, String description, String genre) async {
    Uri uri = Uri.parse("$apiUrl/podcasts/");

    var body = json.encode({
      "id": id,
      "title": title,
      "description": description,
      "genre": genre,
    });
    try {
      final response = await httpClient.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      return StudioPodcast.fromJson(
        json.decode(
          response.body,
        ),
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }
}
