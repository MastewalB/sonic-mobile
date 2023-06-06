part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignUpInitialEvent extends SignupEvent {
  @override
  List<Object?> get props => [];
}

class SignUpSubmitEvent extends SignupEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String country;
  final String dateOfBirth;
  final String email;
  final String password;

  const SignUpSubmitEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.dateOfBirth,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [];
}
