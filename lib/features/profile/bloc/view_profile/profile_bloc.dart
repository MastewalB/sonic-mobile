import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserProfileRepository userProfileRepository;

  ProfileBloc({required this.userProfileRepository}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      // TODO: implement event handler
      emit(ProfileLoading());
      print("profile loading");

      try {
        //perform hive fetch
        await userProfileRepository.getUser().then((value) async {
          print(value);
          emit(ProfileLoaded(value));
        });
      } catch (e) {
        emit(ProfileError('Failed to load profile: $e'));
      }
    });
  }
}
