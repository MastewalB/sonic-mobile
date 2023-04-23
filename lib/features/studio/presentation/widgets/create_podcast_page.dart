import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';

import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';

class CreatePodcastPage extends StatefulWidget {
  const CreatePodcastPage({Key? key}) : super(key: key);

  @override
  State<CreatePodcastPage> createState() => _CreatePodcastPageState();
}

class _CreatePodcastPageState extends State<CreatePodcastPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController genreController = TextEditingController();
    bool validated = true;

    return BlocBuilder<CreatePodcastBloc, CreatePodcastState>(
      builder: (context, state) {
        if (state.status.isError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went Wrong. Please Try again."),
              duration: Duration(seconds: 3),
            ));
          });
        }
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Create New Podcast",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: titleController,
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
                        hintText: "Podcast Title",
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: genreController,
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
                        hintText: "Podast Description",
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
                              debugPrint(
                                  genreController.text.isEmpty.toString());
                              // if (titleController.text.isEmpty ||
                              //     genreController.text.isEmpty ||
                              //     descriptionController.text.isEmpty) {
                              //   setState(() {
                              //     validated = false;
                              //   });
                              // } else {
                              context
                                  .read<CreatePodcastBloc>()
                                  .add(CreateNewPodcastEvent(
                                    title: titleController.value.text,
                                    description:
                                        descriptionController.value.text,
                                    genre: genreController.value.text,
                                  ));
                              Navigator.pop(context);
                              // }
                            },
                            child: Text("Submit")),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
                        ),
                      ],
                    )
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
