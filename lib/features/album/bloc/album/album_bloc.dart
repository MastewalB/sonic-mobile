import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumDataProvider dataProvider;
  final String albumID;

  AlbumBloc(this.dataProvider, {required this.albumID})
      : super(AlbumInitial()) {
    on<LoadAlbumSongs>((event, emit) async {
      emit(AlbumLoading());
      print("album on load");
      print(albumID);
      // try {
      final album = await dataProvider.getAlbum(event.albumID);
      // print(album);
      print("bloc emitting");
      emit(AlbumLoaded(album));
      // }
      //  catch (e) {
      //   emit(AlbumError('Failed to load songs: $e'));
      // }
    });
  }

  // @override
  // Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
  //   // Delegate the event handling to the registered event handlers
  //   await super.mapEventToState(event);
  // }
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
