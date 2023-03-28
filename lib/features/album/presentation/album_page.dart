import 'package:flutter/material.dart';
import 'widgets/album_art.dart';
import 'widgets/audio_list.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: const [
        AlbumArtWidget(
            albumArtUrl: 'albumArtUrl',
            title: 'title',
            artist: 'artist',
            numberOfSongs: 10,
            year: 2022),
        AudioListWidget(songs: [])
      ]),
    );
  }
}
