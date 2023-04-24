import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/studio/presentation/episode_detail_page.dart';

class PodcastDetailPage extends StatelessWidget {
  final StudioPodcast podcast;

  const PodcastDetailPage({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 29, 43),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              PopupMenuButton(
                onSelected: (value){
                  switch (value.toString()){
                    case "Delete Podcast":
                      //

                  }
                },
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem(
                      child: Text(
                        "Edit Podcast",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Text(
                        "Delete Podcast",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 300,
                // width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SvgPicture.asset(
                    "assets/icons/podcast-svgrepo-com.svg",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                podcast.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 0.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                podcast.author.fullName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 10.0),
              child: ReadMore(
                data: podcast.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                trimLines: 4,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                // moreStyle:
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EpisodeDetailPage(
                          podcast: podcast,
                          episode: podcast.episodes[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CardSmall(
                        title: podcast.episodes[index].title,
                        duration: "00:12",
                        image:
                            "https://s1.eestatic.com/2020/01/20/como/podcast-marketing-radio_461216627_142878540_1706x960.jpg",
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: podcast.episodes.length),
          )
        ],
      ),
    );
  }
}
