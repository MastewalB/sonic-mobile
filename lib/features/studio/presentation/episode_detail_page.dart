import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/models/models.dart';

class EpisodeDetailPage extends StatelessWidget {
  final StudioPodcast podcast;
  final StudioEpisode episode;
  final int index;

  const EpisodeDetailPage({
    Key? key,
    required this.podcast,
    required this.episode,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ClipRRect(
                    child:
                        SvgPicture.asset("assets/icons/podcast-svgrepo-com.svg"),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15),
              child: Container(
                padding: EdgeInsets.all(15),
                color: Color.fromARGB(200, 93, 84, 143),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      podcast.author.fullName,
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 5, 0.0, 5),
                      child: Text(
                        "${index + 1} - ${episode.title}",
                        style: TextStyle(
                            inherit: true,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("01:50"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(episode.uploadDate.toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 18, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_fill,
                      size: 43,
                      color: Color.fromARGB(200, 110, 100, 160),
                    ),
                    onPressed: () {
                      ListQueue<Audio> playlist =
                          ListQueue.from(podcast.episodes);
                      context.read<AudioPlayerBloc>().add(PlayAudioEvent(
                            playlist: playlist,
                            currentIndex: podcast.episodes.indexOf(episode),
                            fromCurrentPlaylist: false,
                          ));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cloud_download_rounded,
                      size: 43,
                      color: Color.fromARGB(200, 110, 100, 160),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 20, 0),
              child: ReadMore(
                data: episode.description,
                style: TextStyle(color: Colors.white, fontSize: 17),
                trimLines: 10,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                // moreStyle:
              ),
            ),
          ],
        ),
      ),
    );
  }
}
