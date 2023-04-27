import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';

class RecordingListPage extends StatefulWidget {
  const RecordingListPage({Key? key}) : super(key: key);

  @override
  State<RecordingListPage> createState() => _RecordingListPageState();
}

class _RecordingListPageState extends State<RecordingListPage> {
  Future _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    context
        .read<RecordBloc>()
        .add(ListRecordingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (superContext, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
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

          return RefreshIndicator(
            displacement: 100,
            onRefresh: _refreshData,
            child: SafeArea(
              child: SingleChildScrollView(
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
                                          final recording = state.recordingList
                                              .firstWhere(
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
                              title: Text(e.name.toString(),style: TextStyle(color: Colors.white),),
                              trailing: Text(
                                durationString(e.fileDuration),
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
