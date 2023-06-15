import 'dart:collection';

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
                backgroundColor: Colors.black,
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: secondaryColor,
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
                      padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: 350,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromARGB(255, 88, 85, 85),
                                  spreadRadius: 1,
                                  blurRadius: 7)
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    // width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(state.feed.imageUrl),
                                    ),
                                  ),
                                  Padding(
                      padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 0.0),
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 220,),
                            Text(
                              state.feed.podcastTitle,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 29,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          
                        Text(
                          state.feed.author,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                        height: 15,
                      ),
                      
                      

                        ],
                        ),
                      
                    ),
                                  
                                ],
                              ),
                            ],
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
                            const EdgeInsets.fromLTRB(69.0, 50.0, 69.0, 50.0),
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
