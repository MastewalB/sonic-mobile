import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/core/core.dart';

class AuthenticatedHttpClient extends http.BaseClient {
  SecureStorage secureStorage;
  String refreshUrl;

  AuthenticatedHttpClient({
    required this.secureStorage,
    required this.refreshUrl,
  });

  String inMemoryAccessToken = '';
  String inMemoryRefreshToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY4NTMzODgyMiwiaWF0IjoxNjgyNzQ2ODIyLCJqdGkiOiIyMTcyNTA1M2VmMGQ0MzM3ODA5YTQwNDJjODZkMGI3YyIsInVzZXJfaWQiOiIxODI0Y2E2NC0wMDJkLTRlOTItODIyZS02ZDAwYWJjZmE1MjQiLCJUT0tFTl9UWVBFX0NMQUlNIjoiYWNjZXNzIn0.kQtLn7ICGL9mHuXasu-bStseS-FZ3kETdx9kj1yvM0Q';

  Future<String> get accessToken async {
    if (inMemoryAccessToken.isNotEmpty) return inMemoryAccessToken;
    inMemoryAccessToken =
        await secureStorage.getAccessToken().then((value) async {
      if (value == null || value.isEmpty) {
        await refreshToken.then((refreshValue) async {
          if (refreshValue != '') {
            await refreshAccessToken(refreshUrl, refreshValue);
          } else {
            throw UnauthorizedUserException(ErrorType.HTTP_401_EXPIRED_TOKEN);
          }
        });
      }
      inMemoryAccessToken = value!;
      return inMemoryAccessToken;
    });
    return inMemoryAccessToken;
  }

  Future<String> get refreshToken async {
    if (inMemoryRefreshToken.isNotEmpty) return inMemoryRefreshToken;
    inMemoryRefreshToken = await secureStorage.getRefreshToken().then((value) {
      if (value != null) {
        return value;
      }
      return '';
    });
    return inMemoryRefreshToken;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    return request.send();
  }

  Future<Map<String, String>?> injectToken(Map<String, String>? headers) async {
    if (headers != null) {
      String access = await accessToken;
      if (access.isNotEmpty) {
        if (headers.containsKey("Authorization")) {
          headers.update('Authorization', (value) => 'Bearer  $access');
        } else {
          headers.putIfAbsent('Authorization', () => 'Bearer  $access');
        }
      }
    }
    return headers;
  }

  Future<void> refreshAccessToken(
      String refreshUrl, String refreshToken) async {
    var body = json.encode({
      "refresh": refreshToken,
    });
    final response = await _sendUnstreamed(
      "POST",
      Uri.parse(refreshUrl),
      <String, String>{
        'Content-Type': 'application/json',
      },
      body,
    );

    //Refresh token is invalid, User needs to login again
    if (response.statusCode == 401) {
      inMemoryRefreshToken = "";
      inMemoryAccessToken = "";
      await secureStorage.deleteAll();
      return;
    }

    var data = json.decode(response.body);
    inMemoryAccessToken = data["access"];
    await secureStorage.setAccessToken(data["access"]);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    try {
      var header = await injectToken(headers);
      http.Response response = await _sendUnstreamed("GET", url, header);

      await _checkResponse(url, response).then((value) async {
        if (value == 1) {
          var head = await injectToken(headers);
          response = await _sendUnstreamed('POST', url, head);
        }
      });
      return response;
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var header = await injectToken(headers);
      http.Response response =
          await _sendUnstreamed('POST', url, header, body, encoding);

      await _checkResponse(url, response).then((value) async {
        if (value == 1) {
          var head = await injectToken(headers);
          response = await _sendUnstreamed('POST', url, head, body, encoding);
        }
      });
      return response;
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var header = await injectToken(headers);
      http.Response response =
          await _sendUnstreamed('PUT', url, header, body, encoding);

      await _checkResponse(url, response).then((value) async {
        if (value == 1) {
          var head = await injectToken(headers);
          response = await _sendUnstreamed('PUT', url, head, body, encoding);
        }
      });

      return response;
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var header = await injectToken(headers);
      http.Response response =
          await _sendUnstreamed('PATCH', url, header, body, encoding);

      await _checkResponse(url, response).then((value) async {
        if (value == 1) {
          var head = await injectToken(headers);
          response = await _sendUnstreamed('PATCH', url, head, body, encoding);
        }
      });
      return response;
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var header = await injectToken(headers);
      http.Response response =
          await _sendUnstreamed('DELETE', url, header, body, encoding);

      await _checkResponse(url, response).then((value) async {
        if (value == 1) {
          var head = await injectToken(headers);
          response = await _sendUnstreamed('DELETE', url, head, body, encoding);
        }
      });
      return response;
    } catch (e) {
      throw NetworkException(ErrorType.CONNECTION_ERROR);
    }
  }

  //Returns 1 to retry, 0 to finalize
  Future<int> _checkResponse(Uri url, http.Response response) async {
    int responseValue = 0;
    if (response.statusCode < 400) return responseValue;
    var body = json.decode(response.body);

    if (response.statusCode == 401 && body["code"] == "token_not_valid") {
      await refreshToken.then((value) async {
        if (value != '') {
          await refreshAccessToken(refreshUrl, value);
          responseValue = 1;
        } else {
          throw UnauthorizedUserException(ErrorType.HTTP_401_EXPIRED_TOKEN);
        }
      });
      return responseValue;
    }

    if (response.statusCode == 401 && body["code"] == "user_inactive") {
      throw InactiveUserException(ErrorType.HTTP_401_USER_INACTIVE);
    } else if (response.statusCode == 401) {
      throw UnauthorizedUserException(ErrorType.HTTP_401_EXPIRED_TOKEN);
    } else if (response.statusCode == 404) {
      throw NotFoundException(ErrorType.HTTP_404);
    } else if (response.statusCode == 403) {
      throw PermissionDeniedException(ErrorType.HTTP_403);
    } else if (response.statusCode == 500) {
      throw ServerErrorException(ErrorType.HTTP_500);
    }

    return responseValue;
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<http.Response> _sendUnstreamed(
      String method, Uri url, Map<String, String>? headers,
      [Object? body, Encoding? encoding]) async {
    var request = http.Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return http.Response.fromStream(await send(request));
  }
}
