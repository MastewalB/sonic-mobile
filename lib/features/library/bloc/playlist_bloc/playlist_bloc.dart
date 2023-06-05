import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/library/repository/library_repository.dart';

part 'playlist_event.dart';

part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final LibraryRepository libraryRepository;
  final NotificationCubit notificationCubit;

  PlaylistBloc({
    required this.libraryRepository,
    required this.notificationCubit,
  }) : super(const PlaylistState()) {
    on<PlaylistEvent>((event, emit) {});

    on<AddItemEvent>((event, emit) async {
      emit(state.copyWith(status: PlaylistStatus.loading));
      try {
        await libraryRepository
            .addItemToPlaylist(event.playlistId, event.songId)
            .then((value) => emit(state.copyWith(
                  status: PlaylistStatus.loaded,
                )));
      } on AppException catch (e) {
        notificationCubit.errorNotification(
          message: e.errorType.getMessage,
        );
        emit(state.copyWith(
          status: PlaylistStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<RemoveItemEvent>((event, emit) async {
      emit(state.copyWith(status: PlaylistStatus.loading));
      try {
        await libraryRepository
            .removeItemFromPlaylist(event.playlistId, event.songId)
            .then((value) => emit(state.copyWith(
                  status: PlaylistStatus.loaded,
                )));
      } on AppException catch (e) {
        notificationCubit.errorNotification(
          message: e.errorType.getMessage,
        );
        emit(state.copyWith(
          status: PlaylistStatus.error,
          errorType: e.errorType,
        ));
      }
    });

    on<DeletePlaylistEvent>((event, emit) async {
      emit(state.copyWith(status: PlaylistStatus.loading));
      try {
        await libraryRepository.deletePlaylist(event.playlistId).then((value) {
          emit(state.copyWith(status: PlaylistStatus.loaded));
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: "An Error Occurred.");
        emit(state.copyWith(
          status: PlaylistStatus.error,
          errorType: e.errorType,
        ));
      }
    });
  }
}
