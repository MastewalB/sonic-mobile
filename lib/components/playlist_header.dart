import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/core/core.dart';

class PlaylistHeader extends StatelessWidget {
  const PlaylistHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 920) {
            return _buildWidePlaylist();
            
          }
           else if ( 710 <constraints.maxWidth && constraints.maxWidth < 920) {
            return _buildMiddlePlaylist()
            ;
          }
          else {
            return _buildNormalPlaylist();
            
          }
          
        },
      );

  }
}

Widget _buildNormalPlaylist() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft:Radius.circular(20),
        ),
        color: secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55.0,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 40, 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 220,
                      width: 220,
                      child: Image.asset(
                        'assets/images/playlists.png',
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Playlist",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Playlist",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "The biggest hits",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              )
            ],
          ),
        ],
      ),
    );
}
Widget _buildMiddlePlaylist() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft:Radius.circular(20),
        ),
        color: secondaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 55.0,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 40, 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 220,
                      width: 220,
                      child: Image.asset(
                        'assets/images/playlists.png',
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Playlist",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Playlist Name",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "The biggest hits",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              )
            ],
          ),
        ],
      ),
    );
}
Widget _buildWidePlaylist() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft:Radius.circular(20),
        ),
        color: secondaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 55.0,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 40, 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 260,
                        width: 260,
                        child: Image.asset(
                          'assets/images/playlists.png',
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Playlist",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Playlist Name",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "The biggest hits",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
}