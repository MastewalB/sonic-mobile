import 'package:flutter/material.dart';
import 'package:sonic_mobile/components/playlist_file.dart';
import 'package:sonic_mobile/components/playlist_header.dart';
import '../../components/follower_list.dart';
import '../../components/profile_header.dart';
import '../components/profile_lists.dart';
import '../core/constants/colors.dart';

class DesktopPlaylist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.fromLTRB(defaultPadding,0,defaultPadding,0),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            PlaylistHeader(),
            PlaylistFiles(),
          ],
        ),
      ),
    );
  }
}

