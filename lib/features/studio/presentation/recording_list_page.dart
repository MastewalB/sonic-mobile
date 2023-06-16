import 'dart:collection';
import 'package:sonic_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/record_page.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class RecordingListPage extends StatefulWidget {
  static const String routeName = "recording_list";

  const RecordingListPage({Key? key}) : super(key: key);

  @override
  State<RecordingListPage> createState() => _RecordingListPageState();
}

class _RecordingListPageState extends State<RecordingListPage> {
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<RecordBloc>().add(ListRecordingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text("Your Recordings"),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            switch (value.toString()) {
              case "add_recording":
                Navigator.pushNamed(
                  context,
                  RecordPage.routeName,
                );
            }
          },
          itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem(
                child: Text(
                  "Add a New Recording",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: "add_recording",
              ),
            ];
          },
        )
      ],
    );

    return BlocBuilder<RecordBloc, RecordState>(
      builder: (superContext, state) {
        if (state is LoadingState) {
          return Scaffold(
            appBar: appBar,
            body: const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        }
        if (state is RecordingsLoaded) {
          String durationString(Duration duration) {
            String twoDigits(int n) => n.toString().padLeft(2, "0");
            String twoDigitMinutes =
                twoDigits(duration.inMinutes.remainder(60));
            String twoDigitSeconds =
                twoDigits(duration.inSeconds.remainder(60));
            return "$twoDigitMinutes:$twoDigitSeconds";
          }

          if (state.recordingList.isEmpty) {
            return Scaffold(
              appBar: appBar,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your recordings will appear here.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RecordPage.routeName,
                        );
                      },
                      elevation: 2.0,
                      fillColor: const Color.fromARGB(255, 60, 60, 70),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    )
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            displacement: 100,
            onRefresh: _refreshData,
            child: SafeArea(
              child: Scaffold(
                appBar: appBar,
                body: SingleChildScrollView(
                  child: Column(
                    children: state.recordingList
                        .map(
                          (e) => Dismissible(
                            onDismissed: (direction) async {
                              showDialog(
                                  context: superContext,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete Recording"),
                                      content: Text(
                                          "The recording ${e.name.toString()} will be deleted."),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            final recording =
                                                state.recordingList.firstWhere(
                                                    (element) => element == e);
                                            await recording.file.delete();
                                            superContext
                                                .read<RecordBloc>()
                                                .add(RemoveRecording());
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            key: UniqueKey(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  e.name.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                // trailing: const Icon(
                                //   Icons.more_vert,
                                //   color: Colors.white,
                                // ),
                                onTap: () {
                                  ListQueue<Audio> playlist =
                                      ListQueue.from(state.recordingList);
                                  context.read<AudioPlayerBloc>().add(
                                        PlayAudioEvent(
                                          playlist: playlist,
                                          currentIndex:
                                              state.recordingList.indexOf(e),
                                          fromCurrentPlaylist: false,
                                        ),
                                      );
                                },
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: appBar,
          body: const Center(
            child: Text(
              "Could not fetch recordings.",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
