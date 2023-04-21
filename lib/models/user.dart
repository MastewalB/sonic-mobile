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

  String get fullName => "$fullName $lastName";

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'country': country,
      'is_staff': isStaff,
      'is_active': isActive,
    };
  }
}
