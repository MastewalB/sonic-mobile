import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';

class CreatePodcastPage extends StatefulWidget {
  static const String routeName = "create_podcast";
  const CreatePodcastPage({Key? key}) : super(key: key);

  @override
  State<CreatePodcastPage> createState() => _CreatePodcastPageState();
}

class _CreatePodcastPageState extends State<CreatePodcastPage> {
  bool validated = true;

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;
    double titleFontSize = safeAreaWidth * 8;
    double spacingBox = safeAreaWidth * 10;

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController genreController = TextEditingController();

    return BlocBuilder<CreatePodcastBloc, CreatePodcastState>(
      builder: (context, state) {
        // if (state.status.isError) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: const Text(Constants.connectionError),
        //         duration: Constants.longDuration,
        //         showCloseIcon: true,
        //       ),
        //     );
        //   });
        // }
        if (state.status.isPodcastCreated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, YourPodcastsPage.routeName);
          });
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Create New Podcast",
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
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
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
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
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
                        errorText: !validated ? 'Value Can\'t Be Empty' : null,
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blue, // Set the background color
                            ),
                            onPressed: () {
                              if (titleController.text.isEmpty ||
                                  genreController.text.isEmpty ||
                                  descriptionController.text.isEmpty) {
                                setState(() {
                                  validated = false;
                                });
                              } else {
                                context.read<CreatePodcastBloc>().add(
                                      CreateNewPodcastEvent(
                                        title: titleController.value.text,
                                        description:
                                            descriptionController.value.text,
                                        genre: genreController.value.text,
                                      ),
                                    );
                              }
                            },
                            child: (state.status.isCreatingPodcast)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text("Submit")),
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
        );
      },
    );
  }
}
