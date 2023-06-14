import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/library/bloc/library_bloc/library_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/playlist_detail_page.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/screen_arguments.dart';

class YourPlaylists extends StatelessWidget {
  static const String routeName = "/my_playlists";

  const YourPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;
    double circleAvatarWidth = safeAreaWidth * 8;

    Future _refreshData() async {
      await Future.delayed(const Duration(seconds: 1));
      context.read<LibraryBloc>().add(GetAllPlaylistsByUser());
    }

    return BlocBuilder<LibraryBloc, LibraryState>(
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }
        if (state.status.isError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Could not fetch playlists.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LibraryBloc>().add(
                            GetAllPlaylistsByUser(),
                          );
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            ),
          );
        }
        if (state.status.isLoaded && state.playlists.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Playlists will appear Here.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (dialogContext) {
                            TextEditingController nameController =
                                TextEditingController();
                            return AlertDialog(
                              backgroundColor: Color.fromARGB(255, 47, 49, 66),
                              title: const Text("Enter playlist title."),
                              content: TextField(
                                controller: nameController,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (nameController.text.isNotEmpty) {
                                      context
                                          .read<LibraryBloc>()
                                          .add(CreatePlaylistEvent(
                                            playlistTitle:
                                                nameController.value.text,
                                          ));
                                      Navigator.pop(dialogContext);
                                    }
                                  },
                                  child: const Text(
                                    "Create Playlist",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    elevation: 2.0,
                    fillColor: const Color.fromARGB(255, 60, 60, 70),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          backgroundColor: Color.fromARGB(200, 93, 84, 143),
          color: Colors.white,
          displacement: 100,
          onRefresh: _refreshData,
          child: SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Create New Playlist",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) {
                              TextEditingController nameController =
                                  TextEditingController();
                              return AlertDialog(
                                title: const Text("Enter playlist title."),
                                content: TextField(
                                  controller: nameController,
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (nameController.text.isNotEmpty) {
                                        context
                                            .read<LibraryBloc>()
                                            .add(CreatePlaylistEvent(
                                              playlistTitle:
                                                  nameController.value.text,
                                            ));
                                        Navigator.pop(dialogContext);
                                      }
                                    },
                                    child: const Text(
                                      "Create Playlist",
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PlaylistDetailPage.routeName,
                                arguments: PlaylistDetailArgument(
                                  state.playlists[index],
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                state.playlists[index].playlistTitle,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: circleAvatarWidth,
                                backgroundImage: const AssetImage(
                                  "assets/images/podcast_icon.jpg",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.playlists.length,
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
