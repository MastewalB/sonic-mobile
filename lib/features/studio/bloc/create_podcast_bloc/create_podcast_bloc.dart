import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'create_podcast_event.dart';

part 'create_podcast_state.dart';

class CreatePodcastBloc extends Bloc<CreatePodcastEvent, CreatePodcastState> {
  final StudioRepository studioRepository;
  final NotificationCubit notificationCubit;

  CreatePodcastBloc({
    required this.studioRepository,
    required this.notificationCubit,
  }) : super(const CreatePodcastState()) {
    on<CreatePodcastEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateNewPodcastEvent>((event, emit) async {
      emit(state.copyWith(status: CreatePodcastStatus.createPodcastLoading));
      try {
        await studioRepository
            .createPodcast(event.title, event.description, event.genre)
            .then(
          (value) {
            notificationCubit.successNotification(
                message: "Podcast Successfully Created.");
            emit(state.copyWith(
              status: CreatePodcastStatus.podcastCreated,
              podcast: value,
            ));
          },
        );
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(
          status: CreatePodcastStatus.error,
          errorType: e.errorType,
        ));
      }
    });
  }
}
