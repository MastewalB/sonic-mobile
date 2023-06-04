import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:sonic_mobile/models/models.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 1)
class UserProfile {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String country;
  @HiveField(5)
  final String email;
  @HiveField(6)
  final DateTime dateOfBirth;
  @HiveField(7)
  final bool isActive;
  @HiveField(8)
  final bool isStaff;

  const UserProfile({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.email,
    required this.dateOfBirth,
    required this.isActive,
    required this.isStaff,
  });

  factory UserProfile.fromUser(User user) {
    return UserProfile(
      id: user.id,
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      country: user.country,
      email: user.email,
      dateOfBirth: user.dateOfBirth,
      isActive: user.isActive,
      isStaff: user.isStaff,
    );
  }
}
