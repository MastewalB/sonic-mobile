import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/studio_episode.dart';
import 'package:sonic_mobile/models/studio_podcast.dart';
import 'package:sonic_mobile/core/core.dart';

class HttpStudioRepository implements StudioRepository {
  final String apiUrl = "http://127.0.0.1:8000/api/v1/studio";
  final String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgyNzUwNDIyLCJpYXQiOjE2ODI3NDY4MjIsImp0aSI6ImYwMDNhYjQyM2I5YjRiNmU5NzdhNTE5MGUxZTVhNzUzIiwidXNlcl9pZCI6IjE4MjRjYTY0LTAwMmQtNGU5Mi04MjJlLTZkMDBhYmNmYTUyNCIsIlRPS0VOX1RZUEVfQ0xBSU0iOiJhY2Nlc3MifQ.3t-zhdE5wCW-HAnW-u4sO-zjgT8jH1D6-Src1Uttba4";
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
      var data = json.decode(response.body);
      List<StudioPodcast> allPodcasts = [];

      for (var podcast in data) {
        allPodcasts.add(StudioPodcast.fromJson(podcast));
      }
      return allPodcasts;
    } on AppException {
      rethrow;
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
    } on SocketException {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<bool> createEpisode(String title, String description, String podcastId,
      File episodeFile) async {
    try {
      SecureStorage secureStorage = SecureStorage();
      String? token = await secureStorage.getAccessToken();
      token ??= '';

      final fileBytes = episodeFile.readAsBytesSync();
      http.MultipartRequest request =
          http.MultipartRequest("POST", Uri.parse("$apiUrl/episodes/"));
      http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        "file",
        fileBytes,
        contentType: MediaType('audio', 'mpeg'),
        filename: episodeFile.path.split("/").last,
      );

      request.fields["title"] = title;
      request.fields["description"] = description;
      request.fields["podcast_id"] = podcastId;
      request.headers.addAll({"Authorization": 'Bearer $token'});
      request.headers["Content-Type"] = "multipart/form-data";
      request.files.add(multipartFile);

      var response = await request.send();
      if (response.statusCode == 401) {
        String? refreshToken =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY4NTMzODgyMiwiaWF0IjoxNjgyNzQ2ODIyLCJqdGkiOiIyMTcyNTA1M2VmMGQ0MzM3ODA5YTQwNDJjODZkMGI3YyIsInVzZXJfaWQiOiIxODI0Y2E2NC0wMDJkLTRlOTItODIyZS02ZDAwYWJjZmE1MjQiLCJUT0tFTl9UWVBFX0NMQUlNIjoiYWNjZXNzIn0.kQtLn7ICGL9mHuXasu-bStseS-FZ3kETdx9kj1yvM0Q";
        var body = json.encode({
          "refresh": refreshToken,
        });
        final refreshResponse = await http.post(
          Uri.parse(Constants.refreshTokenUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body,
        );
        if (refreshResponse.statusCode == 401) {
          await secureStorage.deleteAll();
          throw UnauthorizedUserException(ErrorType.HTTP_401_EXPIRED_TOKEN);
        }
        token = json.decode(refreshResponse.body)["access"];
        await secureStorage.setAccessToken(token!);

        http.MultipartRequest request =
            http.MultipartRequest("POST", Uri.parse("$apiUrl/episodes/"));
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
          "file",
          fileBytes,
          contentType: MediaType('audio', 'mpeg'),
          filename: episodeFile.path.split("/").last,
        );

        request.fields["title"] = title;
        request.fields["description"] = description;
        request.fields["podcast_id"] = podcastId;
        request.headers.addAll({"Authorization": 'Bearer $token'});
        request.headers["Content-Type"] = "multipart/form-data";
        request.files.add(multipartFile);
        response = await request.send();
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on SocketException {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }
}
