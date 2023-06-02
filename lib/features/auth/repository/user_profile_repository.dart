import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:hive/hive.dart';

abstract class UserProfileRepository {
  Future<Box> userBox();

  Future<void> setUser(UserProfile userProfile);

  Future<bool> userExists();

  Future<UserProfile> getUser();

  Future<void> deleteUser();
}
