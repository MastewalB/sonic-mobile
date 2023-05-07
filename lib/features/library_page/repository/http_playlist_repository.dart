import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sonic_mobile/models/playlist.dart';

class PlaylistDataProvider {
  final _baseUrl = 'http://localhost:8000/api/v1/playlist/';
  final http.Client httpClient;

  PlaylistDataProvider({required this.httpClient});

  // get playlist by id
  Future<List<Playlist>> getPlaylist(String playlistId) async {
    final response = await httpClient.get(Uri.parse('$_baseUrl/$playlistId'));

    if (response.statusCode == 200) {
      final playlists = jsonDecode(response.body) as List;
      return playlists
          .map((playlist) => Playlist.fromJson(playlist))
          .toList()
          .cast<Playlist>();
    } else {
      throw Exception('Failed to load playlists');
    }
  }

  // create new playlist
  Future<void> createPlaylist(Playlist playlist) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/create/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'created_by': playlist.createdBy,
        'playlist_title': playlist.playlistTitle,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create playlist');
    }
  }

  // update playlist
  Future<void> updatePlaylist(Playlist playlist) async {
    final response = await httpClient.put(
      Uri.parse('$_baseUrl/${playlist.id}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'playlist_title': playlist.playlistTitle,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to update playlist');
    }
  }

  // delete playlist
  Future<void> deletePlaylist(String id) async {
    final response = await httpClient.delete(
      Uri.parse('$_baseUrl/delete/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete playlist');
    }
  }

  // add song to playlist
  Future<void> addSongToPlaylist(String playlistId, String songId) async {
    final response = await httpClient.post(
      Uri.parse('$_baseUrl/add/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'playlist_id': playlistId,
        'song_id': songId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add song to playlist');
    }
  }

  // remove song from playlist
  Future<void> removeSongFromPlaylist(String playlistId, String songId) async {
    final response = await httpClient.delete(
      Uri.parse('$_baseUrl/playlists/remove/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'playlist_id': playlistId,
        'song_id': songId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add song to playlist');
    }
  }

  // get all playlists of user
  Future<List<Playlist>> getPlaylistsByUser(String userId) async {
    final response = await httpClient
        .get(Uri.parse('$_baseUrl/playlists/user_playlist/$userId/'));

    if (response.statusCode == 200) {
      final playlists = jsonDecode(response.body) as List;
      return playlists
          .map((playlist) => Playlist.fromJson(playlist))
          .toList()
          .cast<Playlist>();
    } else {
      throw Exception('Failed to load playlists');
    }
  }
}
