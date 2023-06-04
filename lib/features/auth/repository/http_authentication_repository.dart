import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/core/core.dart';
import 'repository.dart';

class HttpAuthenticationRepository implements AuthenticationRepository {
  final http.Client httpClient;
  final signupUrl = Constants.signupUrl;
  final loginUrl = Constants.loginUrl;

  const HttpAuthenticationRepository({
    required this.httpClient,
  });

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    Uri uri = Uri.parse(loginUrl);
    var body = json.encode({
      "email": email,
      "password": password,
    });

    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      var value = json.decode(response.body);
      if(value.containsKey("message") && value["message"] == "Invalid Email or Password"){
        throw InvalidCredentialException(ErrorType.INVALID_EMAIL_OR_PASSWORD);
      }
      if (!value.containsKey("data") || !value.containsKey("token")) {
        throw AppException(errorType: ErrorType.CONNECTION_ERROR);
      }
      return value;
    } on SocketException {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<Map<String, dynamic>> signup(
    String username,
    String firstName,
    String lastName,
    String country,
    String dateOfBirth,
    String email,
    String password,
  ) async {
    Uri uri = Uri.parse(signupUrl);

    var body = json.encode({
      "email": email,
      "username": username,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "country": country,
      "password": password,
      "is_staff":false
    });

    try {
      final response = await httpClient.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      // print(response.body);
      var value = json.decode(response.body);
      if (!value.containsKey("data") || !value.containsKey("token")) {
        throw AppException(errorType: ErrorType.CONNECTION_ERROR);
      }
      return value;
    } on SocketException {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }
}
