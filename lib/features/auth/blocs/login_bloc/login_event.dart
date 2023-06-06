part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInitialEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}


class LoginSubmitEvent extends LoginEvent{
  final String email;
  final String password;

  const LoginSubmitEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}