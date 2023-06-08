import 'package:flutter/material.dart';
import '../../components/follower_list.dart';
import '../../components/profile_header.dart';
import '../components/profile_lists.dart';
import '../core/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            ProfileHeader(),
             Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding
            (
              padding: EdgeInsets.all(10),
              child: Text(
                
                "My Playlists",
                style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                
                
              ),
            ),
          
            
          ],
        ),
            ProfileLists(),
            FollowerLists(),
          ],
        ),
      ),
    );
  }
}

