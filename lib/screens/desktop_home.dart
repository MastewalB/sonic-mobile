import 'package:flutter/material.dart';
import '../components/playlist_file.dart';
import '../components/storage_details.dart';
import '../core/constants/colors.dart';
import '../../components/header.dart';
import '../../components/my_files.dart';
import '../../components/recent_files.dart';
import '../../components/playlist_header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            PlaylistHeader(),
            PlaylistFiles(),
            
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [

                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                    ],
                  ),
                ),
                SizedBox(width: defaultPadding),
                // On Mobile we don't want to show it
                Expanded(
                  flex: 2,
                  child: StorageDetails(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

