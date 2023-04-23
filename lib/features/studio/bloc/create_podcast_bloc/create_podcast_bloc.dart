import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'create_podcast_event.dart';
part 'create_podcast_state.dart';

class CreatePodcastBloc extends Bloc<CreatePodcastEvent, CreatePodcastState> {
  final StudioRepository studioRepository;

  CreatePodcastBloc({required this.studioRepository}) : super(CreatePodcastState()) {
    on<CreatePodcastEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateNewPodcastEvent>((event, emit) async {
      String title = "Creating Podcast";
      String description =
          "Thank you for applying to the Software Engineering Intern, \n "
          "BS, Summer 2023 - United States role. We carefully reviewed your background and experience, and decided not to proceed with your application at this time.\n"
          "This note is also with respect to your application to Software Developer Intern, BS, Summer 2023 - Canada \n"
          "Although this role didn't work out, we may contact you if we come across another opening that we think could interest you and may be a good match for your skills and experience. \n"
          "Thanks again for your interest in opportunities at Google! ";
      String genre = "Art Science";

      // print(podcast);
      emit(state.copyWith(status: CreatePodcastStatus.createPodcastLoading));
      await studioRepository
          .createPodcast(event.title, event.description, event.genre)
          .then((value) {
        emit(state.copyWith(status: CreatePodcastStatus.podcastCreated));
      }, onError: (error) {
        emit(state.copyWith(
          status: CreatePodcastStatus.error,
        ));
      });
    });
  }
}
