// import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String country;
  final bool isStaff;
  final bool isActive;

  String get fullName => "$firstName $lastName";

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.country,
    required this.isStaff,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      country: json['country'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'username': user.username,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'date_of_birth': user.dateOfBirth.toIso8601String(),
      'country': user.country,
      'is_staff': user.isStaff,
      'is_active': user.isActive,
    };
  }
}

class PublicUser {
  final String id;
  final String firstName;
  final String lastName;
  final String username;

  String get fullName => "$firstName $lastName";

  const PublicUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  factory PublicUser.fromJson(Map<String, dynamic> json) {
    return PublicUser(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  Map<String, dynamic> toJson(PublicUser publicUser) {
    return {
      'id': publicUser.id,
      'username': publicUser.username,
      'first_name': publicUser.firstName,
      'last_name': publicUser.lastName,
    };
  }

  factory PublicUser.fromUser(User user) {
    return PublicUser(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
    );
  }
}
