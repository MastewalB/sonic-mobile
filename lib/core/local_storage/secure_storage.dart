import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage? instance;

  factory SecureStorage() =>
      instance ??= SecureStorage._(const FlutterSecureStorage());

  SecureStorage._(this._storage);

  final FlutterSecureStorage _storage;
  static const String _accessTokenKey = 'ACCESS_TOKEN';
  static const String _refreshTokenKey = 'REFRESH_TOKEN';
  static const String _emailKey = 'EMAIL';
  static const String _usernameKey = 'USERNAME';

  Future<void> persistUserInfo({
    required String email,
    required String username,
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<bool> hasToken() async {
    var value = await _storage.read(key: _accessTokenKey);
    return value != null && value != "";
  }

  Future<void> setAccessToken(String value) async {
    await _storage.write(key: _accessTokenKey, value: value);
  }

  Future<void> setUsername(String value) async {
    await _storage.write(key: _usernameKey, value: value);
  }

  Future<void> setEmail(String value) async {
    await _storage.write(key: _emailKey, value: value);
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: _emailKey);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
