// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/list_playlists.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

class AudioList extends StatelessWidget {
  final List<Song> songs;
  // final String albumArtUrl;
  // final String title;



  const AudioList(
      {Key? key,
        required this.songs,
        // required this.albumArtUrl,
        // required this.title,

        // required this.releaseDate,
        // required this.year
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return const Center(
          child: Text(
            'No items here',
            style: TextStyle(color: Colors.white),
          ));
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 31, 29, 43),
            body: CustomScrollView(slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(14.0, 12.0, 0, 0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 300,
                    // width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/music_icon_image.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Recommended Songs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
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
                            ListQueue<Audio> playlist = ListQueue.from(songs);
                            debugPrint(playlist.elementAt(index).fileUrl);
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
                                onTap: () {},
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: CardSmall(
                                    title: songs[index].title,
                                    duration: "03:12",
                                    // image: 'assets/music_icon_image.jpg',
                                  )),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.more_vert),
                                onPressed: () {
                                  showBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.black,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 300,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: Text(
                                                    "Add to Playlist",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                              return ChoosePlaylist(
                                                                  songId: songs[index].id);
                                                            }));
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }, childCount: songs.length),
              )
            ])));
  }
}

//     return Material(
//       child: Expanded(
//         child: SingleChildScrollView(
//           child: ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: songs.length,
//             itemBuilder: (BuildContext context, int index) {
//               final song = songs[index];
//               return ListTile(
//                 leading: Text('${index + 1}'),
//                 title: Text(song.title),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.more_vert),
//                   onPressed: () {
//                     // Handle options button press
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
