import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'widgets/album_art.dart';
import 'widgets/audio_list.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_state.dart';
// import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatelessWidget {
  final String albumID;
  const AlbumPage({Key? key, required this.albumID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<AlbumBloc>(
        create: (context) => AlbumBloc(
            AlbumDataProvider(httpClient: http.Client()),
            albumID: albumID)
          ..add(LoadAlbumSongs(albumID)),
        child: BlocBuilder<AlbumBloc, AlbumState>(
          builder: (context, state) {
            if (state is AlbumInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AlbumLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AlbumLoaded) {
              // Loaded state, display the album details and song list
              final album = state.album;
              print("album page album");
              // print(album.cover);
              return Column(
                children: [
                  AlbumArtWidget(
                    albumArtUrl: album.cover,
                    title: album.name,
                    artist: album.artist.name,
                    numberOfSongs: album.songs.length,
                    year: 2000,
                  ),
                  AudioListWidget(songs: album.songs),
                ],
              );
            } else if (state is AlbumError) {
              // Error state, show error message
              return Center(
                child: Text('Error: ${state.errorMessage}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
