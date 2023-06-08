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
              // height: 200,
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                album.cover,
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              album.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 3,
            ),
            // Text(
            //   podcast.author,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 12,
            //   ),
            // )
          ],
        ),
      ],
    );
  }
}
