part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfile extends EditProfileEvent {}

class SubmitEditedProfile extends EditProfileEvent {
  final String firstName;
  final String lastName;
  final String password;
  const SubmitEditedProfile(
      {required this.firstName,
      required this.lastName,
      required this.password});
}
