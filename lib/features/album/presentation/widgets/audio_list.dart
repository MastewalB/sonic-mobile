import 'package:flutter/material.dart';
import 'package:sonic_mobile/models/models.dart';

class AudioListWidget extends StatelessWidget {
  final List<Song> songs;

  const AudioListWidget({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return const Center(
          child: Text(
        'No items here',
        style: TextStyle(color: Colors.white),
      ));
    }
    return Material(
      child: Expanded(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (BuildContext context, int index) {
              final song = songs[index];
              return ListTile(
                leading: Text('${index + 1}'),
                title: Text(song.title),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Handle options button press
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
