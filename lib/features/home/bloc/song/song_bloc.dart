import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/models/song.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';

import 'song_event.dart';
import 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final HomeDataProvider songRepository;

  SongBloc(this.songRepository) : super(SongLoadingState());

  Stream<SongState> mapEventToState(SongEvent event) async* {
    if (event is LoadRecommendedSongsEvent ||
        event is RefreshRecommendedSongsEvent) {
      yield SongLoadingState();

      try {
        final List<Song> recommendedSongs =
            await songRepository.getRecommendedSongs();

        yield SongLoadedState(recommendedSongs.take(15).toList());
      } catch (error) {
        yield SongErrorState('Failed to load recommended songs.');
      }
    }
  }
}
