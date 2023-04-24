import 'package:sonic_mobile/core/core.dart';

class AppException implements Exception {
  final ErrorType errorType;

  AppException({required this.errorType});
}

class UnauthorizedUserException extends AppException {
  UnauthorizedUserException(ErrorType errorType) : super(errorType: errorType);
}

class InactiveUserException extends AppException{
  InactiveUserException(ErrorType errorType) : super(errorType: errorType);
}

class NotFoundException extends AppException{
  NotFoundException(ErrorType errorType) : super(errorType: errorType);
}

class PermissionDeniedException extends AppException{
  PermissionDeniedException(ErrorType errorType) : super(errorType: errorType);
}

class ServerErrorException extends AppException{
  ServerErrorException(ErrorType errorType) : super(errorType: errorType);
}