import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';
import 'package:sonic_mobile/features/library/repository/library_repository.dart';

part 'library_event.dart';

part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository libraryRepository;
  final NotificationCubit notificationCubit;
  final UserProfileRepository userProfileRepository;

  LibraryBloc({
    required this.libraryRepository,
    required this.notificationCubit,
    required this.userProfileRepository,
  }) : super(LibraryState()) {
    on<LibraryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllPlaylistsByUser>((event, emit) async {
      emit(LibraryState(status: LibraryStatus.loading));

      try {
        await userProfileRepository.getUser().then((value) async {
          List<Playlist> playlists =
              await libraryRepository.getPlaylistsByUser(value.id);

          emit(
            state.copyWith(
              status: LibraryStatus.loaded,
              playlists: playlists,
            ),
          );
        });
      } on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(status: LibraryStatus.error));
      }
    });

    on<CreatePlaylistEvent>((event, emit)async{
      emit(LibraryState(status: LibraryStatus.loading));
      try{
        await libraryRepository.createPlaylist(event.playlistTitle).then((value) async {
          add(GetAllPlaylistsByUser());
        });
      }on AppException catch (e) {
        notificationCubit.errorNotification(message: e.errorType.getMessage);
        emit(state.copyWith(status: LibraryStatus.error));
      }
    });
  }
}
