part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, loaded, success, userExists, error }

extension SignupStatusX on SignupStatus {
  bool get isInitial => this == SignupStatus.initial;

  bool get isLoading => this == SignupStatus.loading;

  bool get isLoaded => this == SignupStatus.loaded;

  bool get isSuccess => this == SignupStatus.success;

  bool get isUserExists => this == SignupStatus.userExists;

  bool get isError => this == SignupStatus.error;
}

class SignupState extends Equatable {
  final SignupStatus status;
  final ErrorType errorType;

  @override
  List<Object> get props => [status, errorType];

  const SignupState({
    this.status = SignupStatus.initial,
    this.errorType = ErrorType.NONE,
  });

  SignupState copyWith({
    SignupStatus? status,
    ErrorType? errorType,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
    );
  }
}
