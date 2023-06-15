
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/bloc/album/album_event.dart';
// import 'package:sonic_mobile/features/follow/presentation/streaming_users_page.dart';
import 'package:sonic_mobile/features/home/bloc/song/blocs.dart';
import 'package:sonic_mobile/features/home/bloc/song/song_bloc.dart';
import 'package:sonic_mobile/features/home/presentation/widgets/album_display_block.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';
import 'package:sonic_mobile/features/home/bloc/album/album_bloc.dart';
import 'package:sonic_mobile/features/podcast/bloc/podcast_bloc.dart';
import 'package:sonic_mobile/features/podcast/presentation/podcast_grid_view.dart';
import 'package:sonic_mobile/features/profile/presentation/profile.dart';
import 'package:sonic_mobile/features/search/presentation/search_page.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_bar.dart' as SonicSearch;
// import '../../podcast/presentation/widgets/pod_card.dart';
// import 'widgets/catchphrase.dart';
// import 'widgets/header.dart';
// import 'widgets/display_blocks.dart';
import 'package:http/http.dart' as http;
import 'package:sonic_mobile/screens/home_page/podcast_grid_view.dart';

import '../../features/home/presentation/widgets/catchphrase.dart';
import '../../features/home/presentation/widgets/display_blocks.dart';
import '../profile_screen.dart';

class DesktopHomePage extends StatelessWidget {
  static const String routeName = "desktop_home";


  const DesktopHomePage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songRepository = HomeDataProvider(httpClient: http.Client());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            // Center(
            //     child: IconButton(
            //         onPressed: () {
            //           Navigator.pushNamed(
            //               context, StreamingUsersPage.routeName);
            //         },
            //         icon: Icon(
            //           Icons.group,
            //           color: Colors.white,
            //         ))),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              },
                child: Row(
                  children: [
                    SonicSearch.SearchBar(),
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.black,
        body: 
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                CatchPhrase(
                  text: "The Ultimate Sound",
                ),
                
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
                ),
                DesktopPodcastGridView(),
              ],
            ),
          ),
        ),
      );
    
  }
}