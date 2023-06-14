// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/list_playlists.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

class AudioListWidget extends StatelessWidget {
  final List<Song> songs;
  final String albumArtUrl;
  final String title;
  final String artist;
  final int numberOfSongs;

  // final DateTime releaseDate;
  final int year;

  const AudioListWidget(
      {Key? key,
      required this.songs,
      required this.albumArtUrl,
      required this.title,
      required this.artist,
      required this.numberOfSongs,
      // required this.releaseDate,
      required this.year})
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
                              image: NetworkImage(albumArtUrl),
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
                    title,
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
                    artist,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 15,
              //   ),
              // ),
              //add to package and try this
              //             GoogleFonts.roboto(
              // fontSize: 12.0,
              // color: Colors.grey[600],
// );
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 15.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(year.toString(),
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            )),
                        Text(' - ',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            )),
                        Text('$numberOfSongs Songs',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            )),
                      ],
                    )),
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
                                  shape: Border(
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black)),
                                  // clipBehavior: Clip.hardEdge,
                                  // shape: BorderRadius.only(topLeft: Radius.circular(25.0)),
                                  builder: (context) {
                                    return SizedBox(
                                      height: 150,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListTile(
                                              tileColor: Colors.white,
                                              title: Center(
                                                child: Text(
                                                  "Add to Playlist",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
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
                                            ListTile(
                                              title: Center(
                                                child: Text(
                                                  "Go to Similar Songs",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              onTap: () {},
                                            )
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
