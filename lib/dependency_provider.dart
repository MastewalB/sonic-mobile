import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';
import 'package:sonic_mobile/core/core.dart';

class DependencyProvider {
  static http.Client? _httpClient;
  static AuthenticatedHttpClient? _authenticatedHttpClient;
  static HttpStudioRepository? _httpStudioRepository;
  static SecureStorage? _secureStorage;
  static NotificationCubit? _notificationCubit;
  static GlobalKey<ScaffoldMessengerState>? _messengerKey;

  static http.Client? getHttpClient() {
    _httpClient ??= http.Client();
    return _httpClient;
  }

  static AuthenticatedHttpClient? getAuthenticatedHttpClient() {
    _authenticatedHttpClient ??= AuthenticatedHttpClient(
      secureStorage: getSecureStorage()!,
      refreshUrl: Constants.refreshTokenUrl,
    );
    return _authenticatedHttpClient;
  }

  static NotificationCubit? getNotificationCubit() {
    _notificationCubit ??= NotificationCubit();
    return _notificationCubit;
  }

  static GlobalKey<ScaffoldMessengerState>? getScaffoldMessengerKey(){
    return _messengerKey ??= GlobalKey<ScaffoldMessengerState>();
  }

  static HttpStudioRepository? getHttpStudioRepository() {
    _httpStudioRepository ??=
        HttpStudioRepository(httpClient: getAuthenticatedHttpClient()!);
    return _httpStudioRepository;
  }

  static SecureStorage? getSecureStorage() {
    _secureStorage ??= SecureStorage();
    return _secureStorage;
  }
}
