import 'package:sonic_mobile/models/models.dart';

abstract class FollowRepository {
  Future<List<PublicUser>> getAllStreamingFriends(String userId);
  Future<List<String>> getFollowerList(String userId);
  Future<void> followUser(String userId);
  Future<void> unFollowUser(String userId);
  Future<void> startStreaming();
  Future<void> stopStreaming();
  Future<bool> isStreamOn();
}
