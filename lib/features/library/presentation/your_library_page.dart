import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/features/library/presentation/your_playlist_page.dart';
import 'package:sonic_mobile/features/library/bloc/library_bloc/library_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';

class YourLibraryPage extends StatelessWidget {
  static const String routeName = "your_library_tab_page";

  const YourLibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[
      const Tab(
        // icon: SvgPicture.asset(
        //   'assets/icons/music-circle.svg',
        // ),
        text: "Playlists",
      ),
      // const Tab(
      //   // icon: SvgPicture.asset(
      //   //   'assets/icons/music-circle.svg',
      //   // ),
      //   text: "Albums",
      // ),
      // const Tab(
      //   // icon: Icon(Icons.headset_outlined),
      //   text: "Podcasts",
      // )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Library"),
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            Material(
              color: Colors.grey[300],
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                tabs: tabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocProvider(
                    create: (context) => LibraryBloc(
                      libraryRepository:
                          DependencyProvider.getHttpLibraryProvider()!,
                      notificationCubit:
                          DependencyProvider.getNotificationCubit()!,
                      userProfileRepository:
                          DependencyProvider.getUserProfileRepository()!,
                    )..add(GetAllPlaylistsByUser()),
                    child: const YourPlaylists(),
                  ),
                  // Container(),
                  // Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
