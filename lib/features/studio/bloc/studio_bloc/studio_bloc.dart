import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';

part 'studio_event.dart';

part 'studio_state.dart';

class StudioBloc extends Bloc<StudioEvent, StudioState> {
  final StudioRepository studioRepository;
  final NotificationCubit notificationCubit;
  final UserProfileRepository userProfileRepository;

  StudioBloc({
    required this.studioRepository,
    required this.notificationCubit,
    required this.userProfileRepository,
  }) : super(StudioState()) {
    on<StudioEvent>((event, emit) {});


    on<GetAllPodcastsByUserEvent>((event, emit) async {
      emit(state.copyWith(status: StudioStatus.loading));

      try {
        await userProfileRepository.getUser().then((value) async {

          List<StudioPodcast> podcasts =
              await studioRepository.getPodcastsByUser(value.id);
          emit(
            state.copyWith(
              status: StudioStatus.loaded,
              podcasts: podcasts,
            ),
          );
        });

      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(status: StudioStatus.error));
      }
    });
  }
}
