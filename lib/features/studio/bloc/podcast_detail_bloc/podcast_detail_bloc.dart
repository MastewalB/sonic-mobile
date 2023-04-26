import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';

part 'podcast_detail_event.dart';

part 'podcast_detail_state.dart';

class PodcastDetailBloc extends Bloc<PodcastDetailEvent, PodcastDetailState> {
  final StudioRepository studioRepository;

  PodcastDetailBloc({required this.studioRepository})
      : super(const PodcastDetailState()) {
    on<PodcastDetailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<UpdatePodcastEvent>((event, emit) async {
      emit(state.copyWith(status: PodcastDetailStatus.loading));
      try {
        await studioRepository
            .updatePodcast(
                event.id, event.title, event.description, event.genre)
            .then(
          (value) {
            emit(state.copyWith(
              status: PodcastDetailStatus.loaded,
              podcast: value,
            ));
          },
        );
      } on AppException catch (e) {
        emit(state.copyWith(
          status: PodcastDetailStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<DeletePodcastEvent>((event, emit) async {
      emit(state.copyWith(status: PodcastDetailStatus.loading));
      try {
        await studioRepository.deletePodcast(event.id).then(
          (value) {
            emit(state.copyWith(
              status: PodcastDetailStatus.podcastDeleted,
            ));
          },
        );
      } on AppException catch (e) {
        emit(state.copyWith(
          status: PodcastDetailStatus.error,
          errorType: e.errorType,
        ));
      }
    });
  }
}
