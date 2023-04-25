import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';

class YourPodcastsPage extends StatelessWidget {
  static const String routeName = "/my_podcasts";
  YourPodcastsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User user = User(
    //   id: "id",
    //   email: "email",
    //   username: "username",
    //   firstName: "Aj",
    //   lastName: "Simpson",
    //   dateOfBirth: DateTime.now(),
    //   country: "country",
    //   isStaff: false,
    //   isActive: true,
    // );
    // StudioPodcast podcast = StudioPodcast(
    //   id: "id",
    //   title: "My Podcast",
    //   author: PublicUser.fromUser(user),
    //   description:
    //       "Through benediction You tried to rid your mind of malediction But through all this time ou try to peel it off, and it's such a ride (ride) Your desolation led you into this Vile incarnation of consummated bliss I know you need it now to make you feel alive (alive, alive)",
    //   genre: "genre",
    //   numberOfEpisodes: 0,
    //   episodes: [],
    // );
    // final StudioEpisode episode = StudioEpisode(
    //   id: "id",
    //   title: "Why did we . . ",
    //   index: 2,
    //   podcast: "podcast",
    //   description: "description",
    //   uploadDate: DateTime.now(),
    //   file: "file",
    // );
    // final StudioEpisode episode2 = StudioEpisode(
    //   id: "id",
    //   title: "Through the Spillways of your Soul",
    //   index: 2,
    //   podcast: "podcast",
    //   description: "description",
    //   uploadDate: DateTime.now(),
    //   file: "file",
    // );
    //
    // podcast.episodes.add(episode);
    // podcast.episodes.add(episode2);
    // podcast.episodes.add(episode);
    // podcast.episodes.add(episode2);
    // podcast.episodes.add(episode);
    // podcast.episodes.add(episode2);
    // podcast.episodes.add(episode);
    // podcast.episodes.add(episode2);
    // podcast.episodes.add(episode);
    // podcast.episodes.add(episode2);
    // podcast.episodes.add(episode);

    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;

    double circleAvatarWidth = safeAreaWidth * 8;

    Future _refreshData() async {
      await Future.delayed(const Duration(seconds: 1));
      context
          .read<StudioBloc>()
          .add(GetAllPodcastsByUserEvent(userId: "userId"));
    }

    return BlocBuilder<StudioBloc, StudioState>(
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.status.isError) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Could not fetch podcasts.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
        if (state.status.isLoaded && state.podcasts.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text("Your Podcasts will appear Here."),
            ),
          );
        }

        return RefreshIndicator(
          backgroundColor: Color.fromARGB(200, 93, 84, 143),
          color: Colors.white,
          displacement: 100,
          onRefresh: _refreshData,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    "Your Podcasts",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PodcastDetailPage(
                                      podcast: state.podcasts[index])),
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
        );
      },
    );
  }
}
