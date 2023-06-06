import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';

import 'create_podcast_page.dart';

class YourPodcastsPage extends StatelessWidget {
  static const String routeName = "/my_podcasts";

  const YourPodcastsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;
    double circleAvatarWidth = safeAreaWidth * 8;

    Future _refreshData() async {
      await Future.delayed(const Duration(seconds: 1));
      context.read<StudioBloc>().add(GetAllPodcastsByUserEvent());
    }

    return BlocBuilder<StudioBloc, StudioState>(
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
        if (state.status.isError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Your Podcasts"),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    switch (value.toString()) {
                      case "create":
                        Navigator.pushNamed(
                          context,
                          CreatePodcastPage.routeName,
                        );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return const [
                      PopupMenuItem(
                        child: Text(
                          "Create a New Podcast",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: "create",
                      ),
                    ];
                  },
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Could not fetch podcasts.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StudioBloc>().add(
                            GetAllPodcastsByUserEvent(),
                          );
                    },
                    child: Text("Retry"),
                  )
                ],
              ),
            ),
          );
        }
        if (state.status.isLoaded && state.podcasts.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  const Text(
                    "Your Podcasts will appear Here.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: const Color.fromARGB(255, 60, 60, 70),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          backgroundColor: Color.fromARGB(200, 93, 84, 143),
          color: Colors.white,
          displacement: 100,
          onRefresh: _refreshData,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Your Podcasts"),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value.toString()) {
                        case "create":
                          Navigator.pushNamed(
                            context,
                            CreatePodcastPage.routeName,
                          );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return const [
                        PopupMenuItem(
                          child: const Text(
                            "Create a New Podcast",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          value: "create",
                        ),
                      ];
                    },
                  )
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PodcastDetailPage.routeName,
                                arguments: PodcastScreenArgument(
                                  state.podcasts[index],
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                state.podcasts[index].title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: circleAvatarWidth,
                                backgroundImage: const AssetImage(
                                  "assets/images/podcast_icon.jpg",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.podcasts.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
