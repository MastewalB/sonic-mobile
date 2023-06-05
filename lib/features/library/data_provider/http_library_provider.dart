import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/library/repository/library_repository.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/playlist.dart';

class HttpLibraryProvider implements LibraryRepository {
  final http.Client httpClient;

  const HttpLibraryProvider({
    required this.httpClient,
  });

  @override
  Future<void> addItemToPlaylist(String playlistId, String songId) async {
    Uri uri = Uri.parse(Constants.addItemToPlaylistUrl);
    var body = json.encode({
      "playlist_id": playlistId,
      "song_id": songId,
    });
    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<void> createPlaylist(String playlistTitle) async {
    Uri uri = Uri.parse(Constants.playlistCreateUrl);

    var body = json.encode({
      "playlist_title": playlistTitle,
    });

    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    } on AppException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deletePlaylist(String playlistId) async {
    Uri uri = Uri.parse("${Constants.deletePlaylistUrl}${playlistId}/");
    try {
      final response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<Playlist> getPlaylistDetail(String playlistId) async {
    Uri uri = Uri.parse("${Constants.playlistUrl}$playlistId/");

    try {
      final response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      return Playlist.fromJson(json.decode(response.body));
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<List<Playlist>> getPlaylistsByUser(String userId) async {
    Uri uri = Uri.parse("${Constants.getUserPlaylistUrl}$userId");
    try {
      final response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      var data = json.decode(response.body);
      List<Playlist> playlists = [];
      for (var playlist in data) {
        playlists.add(Playlist.fromJson(playlist));
      }
      return playlists;
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<void> removeItemFromPlaylist(String playlistId, String songId) async {
    Uri uri = Uri.parse(Constants.deleteItemFromPlaylistUrl);
    var body = json.encode({
      "playlist_id": playlistId,
      "song_id": songId,
    });
    try {
      final response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }
}
