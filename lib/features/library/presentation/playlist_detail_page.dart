import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/library/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/list_playlists.dart';
import 'package:sonic_mobile/models/models.dart';

class PlaylistDetailPage extends StatefulWidget {
  static const String routeName = "playlist_detail";
  final Playlist playlist;

  const PlaylistDetailPage({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
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
                    actions: [
                      PopupMenuButton(
                        onSelected: (value) {
                          switch (value.toString()) {
                            case "edit":
                              break;
                            case "delete":
                              final playlistBloc = context.read<PlaylistBloc>();
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: const Text("Delete Playlist"),
                                      titleTextStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      content: const Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Do you want to delete this playlist?"),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () {
                                            playlistBloc.add(
                                              DeletePlaylistEvent(
                                                  playlistId:
                                                      widget.playlist.id),
                                            );
                                            Navigator.pop(context);
                                            Navigator.pop(builder);
                                          },
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(builder);
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
                            // PopupMenuItem(
                            //   value: "edit",
                            //   child: Text(
                            //     "Edit Playlist",
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            PopupMenuItem(
                              value: "delete",
                              child: Text(
                                "Delete Playlist",
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
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        // width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          // child: SvgPicture.asset(
                          //   "assets/icons/podcast-svgrepo-com.svg",
                          //   color: Colors.white,
                          // ),
                          child: const Image(
                              image: NetworkImage(
                                  'https://1.bp.blogspot.com/-RgJWXm0t7q0/XIWTSUvY40I/AAAAAAAAIj0/YMDr1bdHzBsryvSU8CEGeSGNlqPh3axlQCK4BGAYYCw/s1600/music%2Bicons.png')),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 0.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        widget.playlist.playlistTitle,
                        style: const TextStyle(
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
                        widget.playlist.createdBy.fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 15,
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
                                  ListQueue.from(widget.playlist.playlistItems);
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
                                        (index + 1).toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    ListQueue<Audio> playlist = ListQueue.from(
                                        widget.playlist.playlistItems);
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
                                  child: CardSmall(
                                    title: widget
                                        .playlist.playlistItems[index].title,
                                    duration: "02:56",
                                    image: 'assets/music_icon_image.jpg',
                                  ),
                                ),
                                IconButton(
                                    color: Colors.white,
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {
                                      showBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.black,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 130,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      tileColor: Colors.white,
                                                      title: Center(
                                                        child: Text(
                                                          "Remove from Playlist",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                PlaylistBloc>()
                                                            .add(RemoveItemEvent(
                                                                playlistId:
                                                                    widget
                                                                        .playlist
                                                                        .id,
                                                                songId: widget
                                                                    .playlist
                                                                    .playlistItems[
                                                                        index]
                                                                    .id));
                                                      },
                                                    ),
                                                    ListTile(
                                                      // tileColor: Colors.white,
                                                      title: Center(
                                                        child: Text(
                                                          "Add to other Playlist",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return ChoosePlaylist(
                                                              songId: widget
                                                                  .playlist
                                                                  .playlistItems[
                                                                      index]
                                                                  .id);
                                                        }));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    }),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: widget.playlist.playlistItems.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
