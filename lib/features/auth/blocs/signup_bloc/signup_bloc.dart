import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository authenticationRepository;
  final NotificationCubit notificationCubit;
  final UserProfileRepository userProfileRepository;
  final SecureStorage secureStorage;

  SignupBloc({
    required this.authenticationRepository,
    required this.notificationCubit,
    required this.userProfileRepository,
    required this.secureStorage,
  }) : super(const SignupState()) {
    on<SignupEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignUpInitialEvent>((event, emit) async {
      emit(state.copyWith(status: SignupStatus.loading));
      try {
        await userProfileRepository.userExists().then((value) {
          if (value) {
            emit(state.copyWith(status: SignupStatus.userExists));
          } else {
            emit(state.copyWith(status: SignupStatus.loaded));
          }
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(
          status: SignupStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<SignUpSubmitEvent>((event, emit) async {
      emit(state.copyWith(status: SignupStatus.loading));
      try {
        await authenticationRepository
            .signup(
          event.username,
          event.firstName,
          event.lastName,
          event.country,
          event.dateOfBirth,
          event.email,
          event.password,
        )
            .then((value) async {
          User user = User.fromJson(value["data"]);
          String accessToken = value["token"]["access"];
          String refreshToken = value["token"]["refresh"];

          await secureStorage
              .persistUserInfo(
                  email: user.email,
                  username: user.username,
                  accessToken: accessToken,
                  refreshToken: refreshToken)
              .then((value) async {
            await userProfileRepository.setUser(UserProfile.fromUser(user));
            notificationCubit.successNotification(
                message:
                    "Sign up Successful. Go to your email and activate your Account!");
            emit(state.copyWith(status: SignupStatus.success));
          });
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(
          status: SignupStatus.error,
          errorType: e.errorType,
        ));
      }
    });
  }
}
