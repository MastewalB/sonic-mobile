import 'package:sonic_mobile/core/core.dart';

enum ErrorType {
  NONE,
  HTTP_401_EXPIRED_TOKEN,
  HTTP_401_USER_INACTIVE,
  HTTP_403,
  HTTP_404,
  HTTP_500,
  CONNECTION_ERROR,
}

extension ErrorTypeX on ErrorType {
  String get getMessage {
    switch (this) {
      case ErrorType.NONE:
        return "";

      case ErrorType.HTTP_401_EXPIRED_TOKEN:
        return Constants.loginRequired;

      case ErrorType.HTTP_401_USER_INACTIVE:
        return Constants.emailVerificationRequired;

      case ErrorType.HTTP_403:
        return Constants.notEnoughPermission;

      case ErrorType.HTTP_404:
        return Constants.notFound;

      case ErrorType.HTTP_500:
        return Constants.serverError;

      case ErrorType.CONNECTION_ERROR:
        return Constants.connectionError;
    }
  }
}
