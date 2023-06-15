import 'package:flutter/material.dart';
import '../../components/follower_list.dart';
import '../../components/profile_header.dart';
import '../components/profile_lists.dart';
import '../core/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "desktop_profile";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black38, actions: [
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
              child: Row(
                children: [
                  Center(
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(width: 15,)
                ],
              ),
            ),
            
          ],),
          body: Container(
            color: Colors.black,
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    child: ProfileHeader(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10,25,0,10),
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
          ),
        ),
      ),
    );
  }
}
