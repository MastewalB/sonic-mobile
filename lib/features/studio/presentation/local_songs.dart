import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/list_songs.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';


class LocalSongs extends StatefulWidget {
  static const String routeName = "local_songs";

  const LocalSongs({Key? key}) : super(key: key);

  @override
  State<LocalSongs> createState() => _LocalSongsState();
}

class _LocalSongsState extends State<LocalSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Indicate if application has permission to the library.
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    // (Optional) Set logging level. By default will be set to 'WARN'.
    //
    // Log will appear on:
    //  * XCode: Debug Console
    //  * VsCode: Debug Console
    //  * Android Studio: Debug and Logcat Console
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Music"),
        elevation: 2,
      ),
      body: Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
                // Default values:
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  // Display error, if any.
                  if (item.hasError) {
                    return Text(item.error.toString());
                  }

                  // Waiting content.
                  if (item.data == null) {
                    return const CircularProgressIndicator();
                  }

                  // 'Library' is empty.
                  if (item.data!.isEmpty) return const Text("Nothing found!");

                  // You can use [item.data!] direct or you can create a:
                  List<SongModel> songs = item.data!;
                  Map<String, List<SongModel>> songsPerFolders =
                      <String, List<SongModel>>{};


                  Set<String> dirs = songs.map((e) {
                    List<String> split = e.data.split("/").toList();
                    String itemName = split.last;
                    String pathName = e.data.substring(0, e.data.length - itemName.length - 1);
                    songsPerFolders[pathName] ??= [];
                    songsPerFolders[pathName]?.add(e);
                    return pathName;
                  }).toSet();

                  List<String> directories = dirs.toList();
                  directories.sort((a, b)=> a.split("/").last.compareTo(b.split("/").last));


                  return ListView.builder(
                    itemCount: directories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FolderSongs.routeName,
                              arguments: FolderSongsArguments(
                                songs:
                                    songsPerFolders[directories[index]] ?? [],
                                folderName: directories[index].split("/").last,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            title: Text(
                              directories[index].split("/").last,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            leading: Image.asset(
                              'assets/music_icon_image.jpg',
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
