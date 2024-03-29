import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/audio_visualizer.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/mic.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';

class RecordPage extends StatefulWidget {
  static const String routeName = "record_page";

  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordBloc, RecordState>(
      builder: (superContext, state) {
        if (state is RecordInitial) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Record New Audio"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: GestureDetector(
                onTap: () {
                  superContext.read<RecordBloc>().add(StartRecordingEvent());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Mic(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tap to Start Recording",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is RecordStoppedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              RecordingListPage.routeName,
              arguments: StudioLibraryScreenArguments(1),
            );
          });
        } else if (state is RecordOnState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Record New Audio"),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Center(
                    child: Row(
                      children: [
                        const Spacer(),
                        StreamBuilder<double>(
                            initialData: -30,
                            stream: superContext
                                .read<RecordBloc>()
                                .amplitudeStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AudioVisualizer(
                                    amplitude: snapshot.data);
                              }
                              if (snapshot.hasError) {
                                return const Text(
                                  'Visualizer failed to load',
                                  style: TextStyle(color: Colors.white),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      TextEditingController nameController =
                          TextEditingController();
                      showDialog(
                          context: superContext,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Enter File Name"),
                              content: TextField(
                                controller: nameController,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    superContext.read<RecordBloc>().add(
                                        StopRecordingEvent(
                                            newName: nameController.text));
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                )
                              ],
                            );
                          });

                      ///We need to refresh [FilesState] after recording is stopped
                      // context.read<FilesCubit>().getFiles();
                    },
                    child: Container(
                      decoration: ConcaveDecoration(
                        shape: const CircleBorder(),
                        depression: 10,
                        colors: const [
                          Color(0xffFF8080),
                          Colors.black45,
                        ],
                      ),
                      height: 100,
                      width: 100,
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text(
              'An Error occurred',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
