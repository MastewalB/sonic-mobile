import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/podcast_detail_bloc/podcast_detail_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/models/models.dart';

class UpdatePodcastPage extends StatefulWidget {
  static const String routeName = "update-podcast";

  final StudioPodcast podcast;

  const UpdatePodcastPage({Key? key, required this.podcast}) : super(key: key);

  @override
  State<UpdatePodcastPage> createState() => _UpdatePodcastPageState();
}

class _UpdatePodcastPageState extends State<UpdatePodcastPage> {
  bool validated = true;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacementNamed(PodcastDetailPage.routeName,
        arguments: PodcastScreenArgument(
          widget.podcast,
        ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;
    double titleFontSize = safeAreaWidth * 8;
    double spacingBox = safeAreaWidth * 10;

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController genreController = TextEditingController();

    return BlocBuilder<PodcastDetailBloc, PodcastDetailState>(
      builder: (context, state) {
        if (state.status.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(Constants.connectionError),
                duration: Constants.longDuration,
                showCloseIcon: true,
              ),
            );
          });
        }
        if (state.status.isLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, PodcastDetailPage.routeName,
                arguments: PodcastScreenArgument(state.podcast!));
          });
        }

        String podcastId = widget.podcast.id;
        titleController.text = widget.podcast.title;
        descriptionController.text = widget.podcast.description;
        genreController.text = widget.podcast.genre;

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
                        "Update Podcast",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
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
                          hintText: "Podcast Title",
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: genreController,
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
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Podcast genre",
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descriptionController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          errorText:
                              !validated ? 'Value Can\'t Be Empty' : null,
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Podcast Description",
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (titleController.text.isEmpty ||
                                    genreController.text.isEmpty ||
                                    descriptionController.text.isEmpty) {
                                  setState(() {
                                    validated = false;
                                  });
                                } else {
                                  context.read<PodcastDetailBloc>().add(
                                        UpdatePodcastEvent(
                                          id: podcastId,
                                          title: titleController.value.text,
                                          description:
                                              descriptionController.value.text,
                                          genre: genreController.value.text,
                                        ),
                                      );
                                }
                              },
                              child: (state.status.isLoading)
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("Update")),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
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
