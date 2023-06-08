import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/colors.dart';




class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 550) {
            return _buildNormalContainer();
            
          } else {
            return _buildWideContainer()
            ;
          }
        },
      );
  }

    Widget _buildNormalContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
        children:[ 
          Row(
          children: [
            Padding
            (
              padding: EdgeInsets.fromLTRB(10, 10, 40, 0),
              child: Column(children: [
                Container(
                  alignment: Alignment.topCenter,
                  
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape. circle,
    color: Color(0xFFffffff),
    boxShadow: [
      BoxShadow(
        color: Colors.blueGrey,
        blurRadius: 1.0, // soften the shadow
        spreadRadius: 2.0, //extend the shadow
        
      )
    ],
  ),
                    child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/dan.jpeg'),
                            radius: 70,
                          ),
                  )
                ),
              ],),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Luhana Daniel",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                                      "22 Public Playlists",
                                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                                      ),
                                    ),
                    ),
                Row(
                  children: [
                    
                
                 Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                                      ".8 Followers",
                                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                                      ),
                                    ),
                    ),
                 Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                                      ".13 Following",
                                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                                      ),
                                    ),
                    ),
                  ],
                )
                
                
            ],)
          ],
        ),
        
               ],
      ),
    );
  }

    Widget _buildWideContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
        children:[ 
          Row(
          children: [
            Padding
            (
              padding: EdgeInsets.fromLTRB(10, 10, 40, 0),
              child: Column(children: [
                Container(
                  alignment: Alignment.topCenter,
                  
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape. circle,
    color: Color(0xFFffffff),
    boxShadow: [
      BoxShadow(
        color: Colors.blueGrey,
        blurRadius: 1.0, // soften the shadow
        spreadRadius: 2.0, //extend the shadow
        
      )
    ],
  ),
                    child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/dan.jpeg'),
                            radius: 70,
                          ),
                  )
                ),
              ],),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Luhana Daniel",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                                          "22 PublPlaylists",
                                          style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                                          ),
                                        ),
                        ),
                                  
                                   Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                                          ".8 Followers",
                                          style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                                          ),
                                        ),
                        ),
                                   Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                                          ".13 Following",
                                          style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                                          ),
                                        ),
                        ),
                      ],
                    ),
                  ],
                )
                
                
            ],)
          ],
        ),
        
               ],
      ),
    );
  }
}