import 'package:flutter/material.dart';

class AlbumArtWidget extends StatelessWidget {
  final String albumArtUrl;
  final String title;
  final String artist;
  final int numberOfSongs;
  // final DateTime releaseDate;
  final int year;

  const AlbumArtWidget(
      {Key? key,
      required this.albumArtUrl,
      required this.title,
      required this.artist,
      required this.numberOfSongs,
      // required this.releaseDate,
      required this.year})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(albumArtUrl),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          artist,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        Opacity(
          opacity: 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$numberOfSongs songs • '),
              Text(
                  // DateFormat.yMMMMd().format(releaseDate),
                  '$year'),
            ],
          ),
        ),
      ],
    );
  }
}
