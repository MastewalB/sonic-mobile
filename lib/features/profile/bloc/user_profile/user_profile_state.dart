part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final PublicUser profile;
  const UserProfileLoaded(this.profile);
}

class UserProfileError extends UserProfileState {
  final String errorMessage;
  const UserProfileError(this.errorMessage);
}
