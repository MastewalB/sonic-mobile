import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumDataProvider dataProvider;

  AlbumBloc(this.dataProvider) : super(AlbumInitial());

  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    if (event is LoadAlbumSongs) {
      yield AlbumLoading();

      try {
        final album = await dataProvider.getAlbum(event.albumID);
        // final List<Song> songs = album.songs;
        yield AlbumLoaded(album);
      } catch (e) {
        yield AlbumError('Failed to load songs');
      }
    }
  }
}

// AlbumBloc to get the songs by giving album object...temporarily void
// class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
//   final AlbumDataProvider dataProvider;

//   AlbumBloc(this.dataProvider) : super(AlbumInitial());

//   @override
//   Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
//     if (event is LoadAlbumSongs) {
//       yield AlbumLoading();

//       try {
//         final List<Song> songs = await dataProvider.getSongs(event.album);
//         yield AlbumLoaded(songs);
//       } catch (e) {
//         yield AlbumError('Failed to load songs');
//       }
//     }
//   }
// }
