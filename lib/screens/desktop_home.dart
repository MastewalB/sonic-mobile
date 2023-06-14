import 'package:flutter/material.dart';
import 'package:sonic_mobile/components/follower_list.dart';
import 'package:sonic_mobile/components/home_song_lists.dart';
import 'package:sonic_mobile/features/profile/presentation/widgets/profile_info.dart';
import '../components/playlist_file.dart';
import '../components/storage_details.dart';
import '../core/constants/colors.dart';
import '../../components/header.dart';
import '../../components/my_files.dart';
import '../../components/recent_files.dart';
import '../../components/profile_lists.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: thirdColor,
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Songs For You",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            HomeSongLists(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Playlists For You",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            HomeSongLists(),
            SizedBox(height: defaultPadding),
           
          ],
        ),
      ),
    );
  }
}
