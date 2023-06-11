import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/podcast/repository/podcast_repository.dart';

part 'podcast_event.dart';

part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final PodcastRepository podcastRepository;

  PodcastBloc({required this.podcastRepository}) : super(PodcastInitial()) {
    on<PodcastEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPodcastById>((event, emit) async {
      emit(PodcastLoading());
      try {
        await podcastRepository
            .getPodcastById(event.podcastId)
            .then((value) async {
          emit(PodcastReady(feed: value));
        });
      } catch (e) {
        print(e.runtimeType);
        print(e.toString());
        emit(PodcastError());
      }
    });
  }
}
