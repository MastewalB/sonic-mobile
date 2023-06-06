import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/models/models.dart';

class ProfileDataProvider {
  final String apiUrl = Constants.apiUrl;
  final http.Client httpClient;

  const ProfileDataProvider({
    required this.httpClient,
  });

  // Future<User> getProfile(userId) async {
  //   try {} catch (e) {
  //     throw Exception('Failed: $e');
  //   }
  //   return
  // }
}
