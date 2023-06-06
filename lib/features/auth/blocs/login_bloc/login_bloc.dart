import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/auth/models/user_profile.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final NotificationCubit notificationCubit;
  final UserProfileRepository userProfileRepository;
  final SecureStorage secureStorage;

  LoginBloc({
    required this.authenticationRepository,
    required this.notificationCubit,
    required this.userProfileRepository,
    required this.secureStorage,
  }) : super(const LoginState()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoginInitialEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));
      try {
        await userProfileRepository.userExists().then((value) {
          if (value) {
            emit(state.copyWith(status: LoginStatus.userExists));
          } else {
            emit(state.copyWith(status: LoginStatus.loaded));
          }
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(
          status: LoginStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<LoginSubmitEvent>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.loading));
      try {
        await authenticationRepository
            .login(event.email, event.password)
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
                message: "Login Successful.");
            emit(state.copyWith(status: LoginStatus.success));
          });
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(
          status: LoginStatus.error,
          errorType: e.errorType,
        ));
      }
    });
  }
}
