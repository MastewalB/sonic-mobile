import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/studio/repository/studio_repository.dart';

part 'podcast_detail_event.dart';

part 'podcast_detail_state.dart';

class PodcastDetailBloc extends Bloc<PodcastDetailEvent, PodcastDetailState> {
  final StudioRepository studioRepository;
  final NotificationCubit notificationCubit;

  PodcastDetailBloc({
    required this.studioRepository,
    required this.notificationCubit,
  }) : super(const PodcastDetailState()) {
    on<PodcastDetailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPodcastDetailEvent>((event, emit) async {});

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
        notificationCubit.errorNotification(message: "An Error Occurred.");
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
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(
          status: PodcastDetailStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<CreateEpisodeInitial>((event, emit) async {
      emit(state.copyWith(status: PodcastDetailStatus.loading));
      List<Recording> recordings = [];
      try {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        String recordingPath =
            await FileManager.getOrCreateFolder(Constants.recordingDirectory);
        final List<FileSystemEntity> files =
            Directory(recordingPath).listSync();

        for (final file in files) {
          String title = file.path.split('/').last.split('.').first;
          recordings.add(
            Recording(
              title,
              "Recordings",
              file.path,
              file: file,
              fileDuration: Duration(seconds: 5),
            ),
          );
        }
        emit(state.copyWith(
          status: PodcastDetailStatus.recordingsLoaded,
          recordings: recordings,
        ));
      } catch (e) {
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(status: PodcastDetailStatus.error));
      }
    });

    on<CreateEpisodeEvent>((event, emit) async {
      emit(state.copyWith(status: PodcastDetailStatus.loading));
      try {
        await studioRepository
            .createEpisode(
          event.title,
          event.description,
          event.podcastId,
          event.file,
        )
            .then(
          (value) {
            if (value == true) {
              notificationCubit.successNotification(
                  message: "Episode Created Successfully.");
              emit(state.copyWith(
                status: PodcastDetailStatus.episodeCreated,
              ));
            } else {
              notificationCubit.errorNotification(
                  message: "An Error Occurred.");
              emit(state.copyWith(
                status: PodcastDetailStatus.error,
              ));
            }
          },
        );
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(
          status: PodcastDetailStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<ListEpisodeRecordingsEvent>((event, emit) async {
      emit(state.copyWith(status: PodcastDetailStatus.loading));
      List<Recording> recordings = [];
      try {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        String recordingPath =
            await FileManager.getOrCreateFolder(Constants.recordingDirectory);
        final List<FileSystemEntity> files =
            Directory(recordingPath).listSync();

        for (final file in files) {
          String title = file.path.split('/').last.split('.').first;
          recordings.add(
            Recording(
              title,
              "Recordings",
              file.path,
              file: file,
              fileDuration: Duration(seconds: 5),
            ),
          );
        }
        emit(state.copyWith(
          status: PodcastDetailStatus.recordingsLoaded,
          recordings: recordings,
        ));
      } catch (e) {
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(status: PodcastDetailStatus.error));
      }
    });
  }
}
