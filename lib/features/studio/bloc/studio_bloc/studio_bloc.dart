import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

part 'studio_event.dart';

part 'studio_state.dart';

class StudioBloc extends Bloc<StudioEvent, StudioState> {
  final StudioRepository studioRepository;

  StudioBloc({required this.studioRepository}) : super(StudioState()) {
    on<StudioEvent>((event, emit) {});


    on<GetAllPodcastsByUserEvent>((event, emit) async {
      emit(state.copyWith(status: StudioStatus.loading));
      await studioRepository.getPodcastsByUser(event.userId).then((value) {
        emit(state.copyWith(status: StudioStatus.loaded, podcasts: value));
      }, onError: (error) {
        emit(state.copyWith(status: StudioStatus.error));
      });
    });
  }
}
