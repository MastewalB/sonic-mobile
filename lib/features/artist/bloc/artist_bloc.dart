import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'package:sonic_mobile/models/models.dart';

part 'artist_event.dart';
part 'artist_state.dart';

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistDataProvider dataProvider;
  final String artistId;

  ArtistBloc(this.dataProvider, {required this.artistId})
      : super(ArtistInitial()) {
    on<LoadArtist>((event, emit) async {
      // TODO: implement event handler
      emit(ArtistLoading());
      final artist = await dataProvider.getArtist(event.artistId);
      emit(ArtistLoaded(artist));
    });
  }
}
