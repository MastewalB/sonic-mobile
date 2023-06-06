import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/models/song.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';

import 'song_event.dart';
import 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final HomeDataProvider songRepository;

  SongBloc(this.songRepository) : super(SongInitial()) {
    on<LoadRecommendedSongsEvent>((event, emit) async {
      print("about to emit");
      emit(SongLoadingState());

      try {
        final List<Song> recommendedSongs =
            await songRepository.getRecommendedSongs();

        emit(SongLoadedState(recommendedSongs.take(15).toList()));
      } catch (error) {
        emit(SongErrorState('Failed to load recommended songs'));
      }
    });

    // on<RefreshRecommendedSongsEvent>((event, emit) async {
    //   emit(SongLoadingState());

    //   try {
    //     final List<Song> recommendedSongs =
    //         await songRepository.getRecommendedSongs();

    //     emit(SongLoadedState(recommendedSongs.take(15).toList()));
    //   } catch (error) {
    //     emit(SongErrorState('Failed to load recommended songs.'));
    //   }
    // });
  }
}
