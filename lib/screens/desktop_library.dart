import 'package:flutter/material.dart';
import 'package:sonic_mobile/components/playlist_file.dart';
import 'package:sonic_mobile/components/playlist_header.dart';
import 'package:sonic_mobile/features/library/presentation/library_page.dart';
import '../../components/follower_list.dart';
import '../../components/profile_header.dart';
import '../components/profile_lists.dart';
import '../components/side_menu.dart';
import '../core/constants/colors.dart';

class DesktopPlaylists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row( children: [
          
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.fromLTRB(defaultPadding,0,defaultPadding,0),
              child: Column(
                children: [
                  SizedBox(height: defaultPadding),
                  LibraryPage(),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

