import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/library/bloc/playlist_bloc/playlist_bloc.dart';
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
                                            context
                                                .read()<PlaylistBloc>()
                                                .add(DeletePlaylistEvent(
                                                  playlistId:
                                                      widget.playlist.id,
                                                ));
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
                    padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
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
                            onTap: () {},
                            onDoubleTap: () {
                              // ListQueue<Audio> playlist =
                              // ListQueue.from(widget.podcast.episodes);
                              // context.read<AudioPlayerBloc>().add(
                              //   PlayAudioEvent(
                              //     playlist: playlist,
                              //     currentIndex: index,
                              //     fromCurrentPlaylist: false,
                              //   ),
                              // );
                            },
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
                                    // ListQueue<Audio> playlist =
                                    // ListQueue.from(widget.podcast.episodes);
                                    // context.read<AudioPlayerBloc>().add(
                                    //   PlayAudioEvent(
                                    //     playlist: playlist,
                                    //     currentIndex: index,
                                    //     fromCurrentPlaylist: false,
                                    //   ),
                                    // );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CardSmall(
                                  title: widget
                                      .playlist.playlistItems[index].title,
                                  duration: "00:12",
                                  image: 'assets/music_icon_image.jpg',
                                ),
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
