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

  Future<User> updateProfile(
      String userId, String firstName, String lastName, String password) async {
    Uri uri = Uri.parse('${apiUrl}accounts/update/');
    var body = json.encode(
        {"first_name": firstName, "last_name": lastName, "password": password});

    try {
      final response = await httpClient.patch(uri,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: body);
      return User.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('Failed: $e');
    }
  }
}
