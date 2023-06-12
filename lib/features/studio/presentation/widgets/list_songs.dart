import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class FolderSongs extends StatefulWidget {
  static const String routeName = "folder_list";
  final List<SongModel> songs;
  final String folderName;

  const FolderSongs({
    Key? key,
    required this.songs,
    required this.folderName,
  }) : super(key: key);

  @override
  State<FolderSongs> createState() => _FolderSongsState();
}

class _FolderSongsState extends State<FolderSongs> {
  Future<bool> _onWillPop() async {
    // Navigator.of(context).maybePop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.folderName,
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: SafeArea(
          child: (widget.songs.isEmpty)
              ? Container()
              : SingleChildScrollView(
                  child: Column(
                    children: widget.songs
                        .map(
                          (e) => BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                            builder: (context, state) {
                              return ListTile(
                                onTap: () {
                                  ListQueue<Audio> playlist =
                                      ListQueue<Audio>();
                                  for (SongModel song in widget.songs) {
                                    if (song.uri != null) {
                                      playlist.add(Audio.fromSongModel(song));
                                    }
                                  }

                                  // if (item.data![index].uri != null) {
                                  context.read<AudioPlayerBloc>().add(
                                        PlayAudioEvent(
                                          playlist: playlist,
                                          currentIndex: widget.songs.indexOf(e),
                                          fromCurrentPlaylist: false,
                                          isLocal: true,
                                        ),
                                      );
                                  // }
                                },
                                leading: Image.asset(
                                  'assets/music_icon_image.jpg',
                                  width: 45,
                                  height: 45,
                                ),
                                title: Text(
                                  e.displayName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: (state.audioQueue!.isNotEmpty &&
                                            state.audioQueue!
                                                    .elementAt(
                                                        state.currentIndex)
                                                    .fileUrl ==
                                                e.data)
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  e.artist ?? "Unknown",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: (state.audioQueue!.isNotEmpty &&
                                            state.audioQueue!
                                                    .elementAt(
                                                        state.currentIndex)
                                                    .fileUrl ==
                                                e.data)
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
