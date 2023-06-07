import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/features/auth/repository/user_profile_repository.dart';
import 'package:sonic_mobile/features/profile/repository/profile_data_provider.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserProfileRepository userProfileRepository;
  final ProfileDataProvider profileRepository;
  final NotificationCubit notificationCubit;
  EditProfileBloc(
      {required this.userProfileRepository,
      required this.profileRepository,
      required this.notificationCubit})
      : super(EditProfileInitial()) {
    on<EditProfile>((event, emit) {
      emit(EditProfileInitial());
    });

    on<SubmitEditedProfile>((event, emit) async {
      emit(SubmittingEditedProfile());
      String userId;
      try {
        await userProfileRepository.getUser().then((value) async {
          userId = value.id;
          print(userId);
          await profileRepository
              .updateProfile(
                  userId, event.firstName, event.lastName, event.password)
              .then((value) async {
            await userProfileRepository.setUser(UserProfile.fromUser(value));
          });
        }).then((value) {
          notificationCubit.successNotification(
              message: "Profile Update Successful.");
          emit(EditProfileSubmitted());
        });
      } catch (e) {
        throw ('Error: $e');
      }
    });
  }
}
