// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
import 'package:sonic_mobile/features/home/bloc/song/blocs.dart';
import 'package:sonic_mobile/features/home/bloc/song/song_bloc.dart';
import 'package:sonic_mobile/features/home/presentation/widgets/album_display_block.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';
import 'package:sonic_mobile/features/home/bloc/album/album_bloc.dart';
import 'package:sonic_mobile/features/profile/presentation/profile.dart';
import 'package:sonic_mobile/features/search/presentation/search_page.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_bar.dart' as SonicSearchBar;
import 'widgets/catchphrase.dart';
import 'widgets/header.dart';
import 'widgets/display_blocks.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  static const String routeName = "home";
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songRepository = HomeDataProvider(httpClient: http.Client());
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, ProfilePage.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Header(
                      profileName: 'Labile',
                    ),
                  ),
                ),
                CatchPhrase(
                  text: "The Ultimate Sound",
                ),
                SonicSearchBar.SearchBar(),
                BlocProvider<SongBloc>(
                  create: (context) => SongBloc(songRepository),
                  child: Builder(
                    builder: (context) {
                      // Access the SongBloc instance using the context
                      final songBloc = context.read<SongBloc>();

                      // Dispatch the LoadRecommendedSongsEvent
                      songBloc.add(LoadRecommendedSongsEvent());

                      // Return the DisplayBlock widget
                      return DisplayBlock(
                        desc: "Songs you may like",
                      );
                    },
                  ),
                ),
                BlocProvider<AlbumBloc>(
                  create: (context) => AlbumBloc(songRepository),
                  child: Builder(
                    builder: (context) {
                      // Access the SongBloc instance using the context
                      final albumBloc = context.read<AlbumBloc>();

                      // Dispatch the LoadRecommendedSongsEvent
                      albumBloc.add(LoadHomeAlbumsEvent());

                      // Return the DisplayBlock widget
                      return AlbumDisplayBlock(
                        desc: "Albums you may like",
                      );
                    },
                  ),
                )
              ],
            )));
  }
}
