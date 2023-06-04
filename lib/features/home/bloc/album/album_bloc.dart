import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final HomeDataProvider songRepository;

  AlbumBloc(this.songRepository) : super(AlbumInitial()) {
    on<AlbumEvent>((event, emit) async {
      // TODO: implement event handler
      emit(AlbumLoading());

      try {
        final List<Album> recommendedAlbums =
            await songRepository.getRecommendedAlbums();

        emit(AlbumLoadedState(recommendedAlbums.take(15).toList()));
      } catch (error) {
        emit(AlbumErrorState('Failed to load recommended songs'));
      }
    });
  }
}
