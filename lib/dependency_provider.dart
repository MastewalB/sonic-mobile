import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:audioplayers/audioplayers.dart';

class DependencyProvider {
  static http.Client? _httpClient;
  static AuthenticatedHttpClient? _authenticatedHttpClient;
  static HttpStudioRepository? _httpStudioRepository;
  static SecureStorage? _secureStorage;
  static AudioPlayer? _audioPlayer;
  static AudioHandler? _audioHandler;

  static NotificationCubit? _notificationCubit;
  static GlobalKey<ScaffoldMessengerState>? _messengerKey;

  static http.Client? getHttpClient() {
    _httpClient ??= http.Client();
    return _httpClient;
  }

  static AudioPlayer? getAudioPlayer() {
    _audioPlayer ??= AudioPlayer();
    return _audioPlayer;
  }

  static Future<AudioHandler?> getAudioHandler() async {
    _audioHandler ??= await initAudioService();
    return _audioHandler;
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

  static GlobalKey<ScaffoldMessengerState>? getScaffoldMessengerKey() {
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
