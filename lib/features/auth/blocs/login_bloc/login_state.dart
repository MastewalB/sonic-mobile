part of 'login_bloc.dart';

enum LoginStatus { initial, loading, loaded, success, error }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;

  bool get isLoading => this == LoginStatus.loading;

  bool get isLoaded => this == LoginStatus.loaded;

  bool get isSuccess => this == LoginStatus.success;

  bool get isError => this == LoginStatus.error;
}

class LoginState extends Equatable {
  final LoginStatus status;
  final ErrorType errorType;

  const LoginState({
    this.status = LoginStatus.initial,
    this.errorType = ErrorType.NONE,
  });

  @override
  List<Object> get props => [status, errorType];

  LoginState copyWith({
    LoginStatus? status,
    ErrorType? errorType,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
    );
  }
}
