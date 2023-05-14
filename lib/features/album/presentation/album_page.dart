import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/album_art.dart';
import 'widgets/audio_list.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_state.dart';
// import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'package:http/http.dart' as http;

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            AlbumBloc(AlbumDataProvider(httpClient: http.Client())),
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
              return ListView(
                children: [
                  AlbumArtWidget(
                    albumArtUrl: album.cover,
                    title: album.title,
                    artist: album.artist.name,
                    numberOfSongs: state.songs.length,
                    year: album.year,
                  ),
                  AudioListWidget(songs: state.songs),
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
