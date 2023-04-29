import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/podcast_detail_bloc/podcast_detail_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_episode_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/update_podcast_page.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/studio/presentation/episode_detail_page.dart';

class PodcastDetailPage extends StatefulWidget {
  static const String routeName = "podcast-detail";
  final StudioPodcast podcast;

  const PodcastDetailPage({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  @override
  State<PodcastDetailPage> createState() => _PodcastDetailPageState();
}

class _PodcastDetailPageState extends State<PodcastDetailPage> {
  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed(
      StudioLibrary.routeName,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastDetailBloc, PodcastDetailState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.status.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(Constants.connectionError),
                duration: Constants.longDuration,
                showCloseIcon: true,
              ),
            );
          });
        }
        if (state.status.isPodcastDeleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(Constants.podcastDeleted),
                duration: Constants.longDuration,
                showCloseIcon: true,
              ),
            );
            Navigator.pushReplacementNamed(context, StudioLibrary.routeName);
          });
        }

        return WillPopScope(
          onWillPop: _onWillPop,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 31, 29, 43),
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          StudioLibrary.routeName,
                        );
                      },
                    ),
                    actions: [
                      PopupMenuButton(
                        onSelected: (value) {
                          switch (value.toString()) {
                            case "edit":
                              Navigator.pushReplacementNamed(
                                context,
                                UpdatePodcastPage.routeName,
                                arguments: PodcastScreenArgument(widget.podcast),
                              );
                              break;
                            case "delete":
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text("Delete Podcast"),
                                      titleTextStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Do you want to delete this podcast?"),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () {
                                            context.read<PodcastDetailBloc>().add(
                                                DeletePodcastEvent(
                                                    id: widget.podcast.id));
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  });
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
                              value: "edit",
                            ),
                            PopupMenuItem(
                              child: Text(
                                "Delete Podcast",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              value: "delete",
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
                        widget.podcast.title,
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
                        widget.podcast.author.fullName,
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
                        data: widget.podcast.description,
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
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EpisodeDetailPage(
                                  podcast: widget.podcast,
                                  episode: widget.podcast.episodes[index],
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
                                title: widget.podcast.episodes[index].title,
                                duration: "00:12",
                                image:
                                    "https://s1.eestatic.com/2020/01/20/como/podcast-marketing-radio_461216627_142878540_1706x960.jpg",
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: widget.podcast.episodes.length),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    CreateEpisodePage.routeName,
                    arguments: CreateEpisodeScreenArguments(widget.podcast),
                  );
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
