import 'package:flutter/material.dart';
import 'package:sonic_mobile/components/playlist_file.dart';
import 'package:sonic_mobile/components/playlist_header.dart';
import 'package:sonic_mobile/screens/profile_screen.dart';
import '../../components/follower_list.dart';
import '../../components/profile_header.dart';
import '../components/profile_lists.dart';
import '../core/constants/colors.dart';
import '../features/profile.dart';

class DesktopPlaylist extends StatelessWidget {
  static const String routeName = "desktop_playlist";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          actions: [
            Center(
                child: IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.group,
                      color: Colors.white,
                    ))),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, ProfileScreen.routeName);
              },
              child: Center(
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
        ),
      body: SafeArea(
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
      ),
    );
  }
}

