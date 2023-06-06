import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:hive/hive.dart';
import 'package:sonic_mobile/features/auth/repository/user_profile_repository.dart';

class UserProfileProvider implements UserProfileRepository {
  final String userBoxName = Constants.userProfileBoxName;

  @override
  Future<Box> userBox() async {
    var box = await Hive.openBox(userBoxName);
    return box;
  }

  @override
  Future<void> setUser(UserProfile userProfile) async {
    final box = await userBox();
    await box.put(userBoxName, userProfile);
  }

  @override
  Future<bool> userExists() async {
    final box = await userBox();
    return box.containsKey(userBoxName);
  }

  @override
  Future<UserProfile> getUser() async {
    final box = await userBox();
    UserProfile userProfile = box.get(userBoxName);
    return userProfile;
  }

  @override
  Future<void> deleteUser() async {
    final box = await userBox();
    await box.clear();
  }
}
