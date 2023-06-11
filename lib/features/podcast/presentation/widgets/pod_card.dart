import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sonic_mobile/models/models.dart';

class PodCard extends StatelessWidget {
  final PodcastSearchResult podcast;

  const PodCard({Key? key, required this.podcast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
              // height: 200,
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                podcast.imageUrl,
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
              podcast.title,
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
            Text(
              podcast.author,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            )
          ],
        ),
      ],
    );
  }
}
