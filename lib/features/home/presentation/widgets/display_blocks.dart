import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import '../../../../models/audio.dart';
import '../../bloc/song/blocs.dart';

class DisplayBlock extends StatelessWidget {
  final String desc;

  const DisplayBlock({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(
            desc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: BlocBuilder<SongBloc, SongState>(
            builder: (context, state) {
              if (state is SongErrorState) {
                return const Center(
                  child: Text(
                    "A Network Error Occurred",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              if (state is SongLoadedState) {
                final songs = state.songs; // Access the songs from the state
                if(songs.isEmpty){
                  return const Center(
                    child: Text(
                      "No Songs found",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      songs.length, // Use the count of songs from the state
                  itemBuilder: (BuildContext context, int index) {
                    final song =
                        songs[index]; // Access the song based on the index

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                ListQueue<Audio> playlist =
                                    ListQueue.from(songs);
                                debugPrint(playlist.elementAt(index).fileUrl);
                                context.read<AudioPlayerBloc>().add(
                                      PlayAudioEvent(
                                        playlist: playlist,
                                        currentIndex: index,
                                        fromCurrentPlaylist: false,
                                      ),
                                    );
                              },
                              child: Container(
                                height: 120.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(song.album
                                        .cover), // Use the cover URL from the song object
                                  ),
                                ),
                              )),
                          const SizedBox(height: 8.0),
                          Text(
                            song.title, // Use the title from the song object
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            song.artist
                                .name, // Use the artist from the song object
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              // Show a placeholder or loading state when songs are not yet loaded
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
