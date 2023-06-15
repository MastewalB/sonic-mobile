import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/follow/repository/follow_repository.dart';
import 'package:sonic_mobile/models/user.dart';

class HttpFollowProvider implements FollowRepository {
  final http.Client httpClient;

  const HttpFollowProvider({
    required this.httpClient,
  });

  @override
  Future<List<PublicUser>> getAllStreamingFriends(String userId) async {
    Uri uri = Uri.parse(Constants.streamingUsersUrl);
    try {
      final response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      List<PublicUser> users = [];
      var data = json.decode(response.body);
      for (var user in data) {
        users.add(PublicUser.fromJson(user));
      }
      return users;
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<List<String>> getFollowerList(String userId) async {
    Uri uri = Uri.parse("${Constants.followerListUrl}$userId/");

    try {
      final response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      List<String> users = [];
      var data = json.decode(response.body);
      for (var user in data) {
        users.add(user["followee"]);
      }
      return users;
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<void> followUser(String userId) async {
    Uri uri = Uri.parse(Constants.followUrl);
    var body = json.encode({
      "followee": userId,
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
  Future<void> unFollowUser(String userId) async {
    Uri uri = Uri.parse(Constants.followUrl);
    var body = json.encode({
      "followee_id": userId,
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

  @override
  Future<void> startStreaming() async {
    Uri uri = Uri.parse(Constants.toggleStreamUrl);
    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        }
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<void> stopStreaming() async {
    Uri uri = Uri.parse(Constants.toggleStreamUrl);
    try {
      final response = await httpClient.delete(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        }
      );
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<bool> isStreamOn() async {
    Uri uri = Uri.parse(Constants.checkStreamStatusUrl);
    try {
      final response = await httpClient.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // print(json.decode(response.body));
      return json.decode(response.body)["status"];
    } on SocketException catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }
}
/*

 */