import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/podcast/bloc/podcast_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class FeedDetailPage extends StatefulWidget {
  const FeedDetailPage({Key? key}) : super(key: key);

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        print(state.toString());
        if (state is PodcastError) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        if (state is PodcastReady) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: SafeArea(
              child: Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        state.feed.podcastTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                      sliver: SliverToBoxAdapter(
                        child: SizedBox(
                          height: 300,
                          // width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              errorWidget: (BuildContext context, _, __) =>
                                  Container(
                                // fit: BoxFit.cover,
                                child: SvgPicture.asset(
                                    'assets/icons/music-circle.svg'),
                              ),
                              placeholder: (BuildContext context, _) =>
                                  Container(
                                // fit: BoxFit.cover,
                                color: Colors.black26,
                                child: SvgPicture.asset(
                                    'assets/icons/music-circle.svg'),
                              ),
                              imageUrl: state.feed.imageUrl,
                              height: 350,
                              width: 350,
                            ),
                            // Image.network(state.feed.imageUrl),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 0.0),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          state.feed.podcastTitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          state.feed.author,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 10.0),
                        child:
                            // Markdown(
                            //   data: state.feed.description,
                            //   shrinkWrap: true,
                            //   selectable: true,
                            // )
                            ReadMore(
                          data: state.feed.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
                            child: InkWell(
                              onTap: () {
                                ListQueue<Audio> playlist =
                                    ListQueue.from(state.feed.episodes);
                                context.read<AudioPlayerBloc>().add(
                                      PlayAudioEvent(
                                        playlist: playlist,
                                        currentIndex: index,
                                        fromCurrentPlaylist: false,
                                      ),
                                    );
                              },
                              onDoubleTap: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          (state.feed.episodes.length - index)
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      ListQueue<Audio> playlist =
                                          ListQueue.from(state.feed.episodes);
                                      context.read<AudioPlayerBloc>().add(
                                            PlayAudioEvent(
                                              playlist: playlist,
                                              currentIndex: index,
                                              fromCurrentPlaylist: false,
                                            ),
                                          );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        ListQueue<Audio> playlist =
                                            ListQueue.from(state.feed.episodes);
                                        context.read<AudioPlayerBloc>().add(
                                              PlayAudioEvent(
                                                playlist: playlist,
                                                currentIndex: index,
                                                fromCurrentPlaylist: false,
                                              ),
                                            );
                                      },
                                      child: Center(
                                        child: CardSmall(
                                          title:
                                              state.feed.episodes[index].title,
                                          duration: state
                                              .feed.episodes[index].duration,
                                          // image: state.feed.imageUrl,
                                          fromAsset: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: state.feed.episodes.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
