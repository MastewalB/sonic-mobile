import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sonic_mobile/models/models.dart';

class AlbumCard extends StatelessWidget {
  final AlbumInfo album;

  const AlbumCard({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              album.cover,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ],
    );
  }
}
