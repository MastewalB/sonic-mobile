import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'package:sonic_mobile/features/artist/bloc/artist_bloc.dart';
import 'package:sonic_mobile/features/recommendation/bloc/recommend_bloc.dart';
import 'package:sonic_mobile/features/recommendation/repository/http_recommend.dart';

import 'song_list.dart';
import 'package:sonic_mobile/features/album/repository/http_music_repository.dart';
import 'package:http/http.dart' as http;

class RecommendationPage extends StatelessWidget {
  final String songId;
  const RecommendationPage({Key? key, required this.songId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<RecommendBloc>(
        create: (context) => RecommendBloc(
            RecommendationDataProvider(httpClient: http.Client()),
            )
          ..add(LoadRecommendation(songId)),
        child: BlocBuilder<RecommendBloc, RecommendState>(
          builder: (context, state) {
            if (state is RecommendInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RecommendLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RecommendLoaded) {
              final songs = state.songs;
              // print(artist.cover);
              return AudioList(
                songs: songs

              );
            } else if (state is ArtistError) {
              // Error state, show error message
              return Center(
                child: Text('Error'),
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
