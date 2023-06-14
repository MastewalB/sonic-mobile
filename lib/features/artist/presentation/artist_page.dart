import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'package:sonic_mobile/features/artist/bloc/artist_bloc.dart';

import 'album_list.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'package:http/http.dart' as http;

class ArtistPage extends StatelessWidget {
  final String artistID;
  const ArtistPage({Key? key, required this.artistID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<ArtistBloc>(
        create: (context) => ArtistBloc(
            ArtistDataProvider(httpClient: http.Client()),
            artistId: artistID)
          ..add(LoadArtist(artistID)),
        child: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            if (state is ArtistInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ArtistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ArtistLoaded) {
              final artist = state.artist;
              // print(artist.cover);
              return AlbumListWidget(
                albums: artist.albums,
                artistUrl: artist.picture,
                name: artist.name,
                numberOfAlbums: artist.albums.length,
              );
            } else if (state is ArtistError) {
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
