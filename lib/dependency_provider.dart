import 'package:http/http.dart' as http;
import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';

class DependencyProvider {
  static http.Client? _httpClient;
  static HttpStudioRepository? _httpStudioRepository;

  static http.Client? getHttpClient() {
    _httpClient ??= http.Client();
    return _httpClient;
  }

  static HttpStudioRepository? getHttpStudioRepository() {
    _httpStudioRepository ??=
        HttpStudioRepository(httpClient: getHttpClient()!);
    return _httpStudioRepository;
  }
}
