import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_state.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/profile/repository/profile_data_provider.dart';
import 'package:sonic_mobile/models/models.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ProfileDataProvider dataProvider;
  UserProfileBloc(this.dataProvider) : super(UserProfileInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(UserProfileLoading());
      try {
        final profile = await dataProvider.getProfile(event.userId);
        emit(UserProfileLoaded(profile));
      } catch (e) {
        // emit(UserProfileError('Failed to load profile: $e'));
      }
    });
  }
}
