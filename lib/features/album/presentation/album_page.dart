import 'package:flutter/material.dart';
import 'widgets/album_art.dart';
import 'widgets/audio_list.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(children: const [
        AlbumArtWidget(
            albumArtUrl:
                'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg',
            title: 'While in Paris',
            artist: 'Dorothy',
            numberOfSongs: 12,
            year: 2022),
        AudioListWidget(songs: [])
      ]),
    );
  }
}
