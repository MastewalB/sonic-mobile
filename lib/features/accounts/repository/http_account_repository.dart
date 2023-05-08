import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sonic_mobile/models/users.dart';

class HttpAccountsRepository {
  final http.Client httpClient;
  
  const HttpAccountsRepository({required this.httpClient});
  
  Future<User> createUser(
      String password,
      String email,
      String username,
      String firstName,
      String lastName,
      String dateOfBirth,
      String country) async {
    try {
      Uri url = Uri.parse("uri");
      var body = json
          .encode({"username": username, "firstName": firstName, "lastName": lastName, "dateOfBirth": dateOfBirth, "country": country, "email":email , "password":password});

      final response = await httpClient.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          body: body
        },
      );
    } catch (e) {
      rethrow;
    }
  }
/*   Future<User> loginWithEmailAndPassword(
      String email, String password) async {
    Uri url = Uri.parse("uri");
    url = url + 'login/';
    final response = await http.post(
      Uri.parse(url + 'login/'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to login user');
    }
  }

  Future<void> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'reset_password/'),
      body: {'email': email},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  } */

  // Add implementation for other authentication methods as required
}

