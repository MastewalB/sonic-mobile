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
            ProfileLists(),
            FollowerLists(),
          ],
        ),
      ),
    );
  }
}

