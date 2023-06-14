import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/podcast/bloc/podcast_bloc.dart';
import 'package:sonic_mobile/features/podcast/data_provider/http_podcast_provider.dart';
import 'package:sonic_mobile/features/podcast/presentation/feed_detail_page.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/podcast/presentation/widgets/pod_card.dart';
import 'package:http/http.dart' as http;

class PodcastGridView extends StatelessWidget {
  PodcastGridView({Key? key}) : super(key: key);

  final HttpPodcastProvider podcastSearchAPIProvider =
      HttpPodcastProvider(httpClientLibrary: http.Client());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: podcastSearchAPIProvider.getItunesTopList(),
      builder: (BuildContext context,
          AsyncSnapshot<List<PodcastSearchResult>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              "Unknown Error ${snapshot.error.toString()}",
              style: const TextStyle(color: Colors.white),
            ));
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Text(
                    "Top Podcasts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BlocProvider(
                              create: (context) => PodcastBloc(
                                  podcastRepository:
                                      DependencyProvider.getHttpPodcastProvider()!)
                                ..add(GetPodcastById(
                                    podcastId: snapshot.data![index].id)),
                              child: const FeedDetailPage(),
                            );
                          }));
                        },
                        child: PodCard(podcast: snapshot.data![index]),
                      );
                    }),
              ],
            );
          } else {
            return Center(
                child: const Text("Empty data",
                    style: TextStyle(color: Colors.white)));
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
