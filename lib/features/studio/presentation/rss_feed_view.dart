import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RssView extends StatelessWidget {
  final String podcastId;
  const RssView({required this.podcastId, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      podcastId,
      style: TextStyle(color: Colors.white),
    );
  }
}
