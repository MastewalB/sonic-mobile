import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/podcast_detail_bloc/podcast_detail_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/models/models.dart';

class CreateEpisodePage extends StatefulWidget {
  static const String routeName = "create_episode";
  final StudioPodcast podcast;

  const CreateEpisodePage({
    Key? key,
    required this.podcast,
  }) : super(key: key);

  @override
  State<CreateEpisodePage> createState() => _CreateEpisodePageState();
}

class _CreateEpisodePageState extends State<CreateEpisodePage> {
  bool validated = true;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed(
      PodcastDetailPage.routeName,
      arguments: PodcastScreenArgument(widget.podcast),
    );
    return true;
  }

  File? _file;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.addListener(() {
      final String text = titleController.text;
      titleController.value = titleController.value.copyWith(text: text);
    });

    descriptionController.addListener(() {
      final String text = descriptionController.text;
      descriptionController.value =
          descriptionController.value.copyWith(text: text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastDetailBloc, PodcastDetailState>(
      builder: (superContext, state) {
        if (state.status.isLoading) {
          return const Material(
            color: Color.fromARGB(255, 31, 29, 43),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.status.isEpisodeCreated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              PodcastDetailPage.routeName,
              arguments: PodcastScreenArgument(
                widget.podcast,
              ),
            );
          });
        }
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Create New Episode",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: titleController,
                        decoration: InputDecoration(
                          errorText:
                              !validated ? 'Value Can\'t Be Empty' : null,
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Title",
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descriptionController,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          errorText:
                              !validated ? 'Value Can\'t Be Empty' : null,
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Description",
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          const Text(
                            "Choose File",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          (_file != null)
                              ? Text(
                                  _file!.path.split('/').last,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(),
                          (_file != null) ? const Spacer() : const SizedBox(),
                          ElevatedButton(
                            onPressed: () {
                              superContext.read<PodcastDetailBloc>().add(
                                    ListEpisodeRecordingsEvent(),
                                  );

                              showDialog(
                                context: superContext,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: state.recordings!
                                            .map(
                                              (e) => Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: ListTile(
                                                  onTap: () {
                                                    _file = File(e.file.path);
                                                    debugPrint(_file!.path);
                                                    setState(() {});
                                                  },
                                                  title: Text(e.name),
                                                  trailing: Text(e.fileDuration
                                                      .toString()),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Select',
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
                                },
                              );
                            },
                            child: const Text("Open Storage"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (titleController.text.isEmpty ||
                                  descriptionController.text.isEmpty) {
                                setState(() {
                                  validated = false;
                                });
                              } else {
                                context.read<PodcastDetailBloc>().add(
                                      CreateEpisodeEvent(
                                        title: titleController.value.text,
                                        description:
                                            descriptionController.value.text,
                                        file: _file!,
                                        podcastId: widget.podcast.id,
                                      ),
                                    );
                              }
                            },
                            child: const Text("Submit"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                PodcastDetailPage.routeName,
                                arguments:
                                    PodcastScreenArgument(widget.podcast),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
