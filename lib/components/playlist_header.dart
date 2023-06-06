import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/core/core.dart';


class PlaylistHeader extends StatelessWidget {
  const PlaylistHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color:secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
        children:[ 
          Row(
          children: [
            Padding
            (
              padding: EdgeInsets.fromLTRB(20, 50, 40,20),
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  height: 180,
                  width: 180,
                  child: Image.asset(
                      'assets/images/playlists.png',
                      fit: BoxFit.fill,
                    colorBlendMode: BlendMode.darken,
                    ),
                ),
              ],),
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
                SizedBox(
                  
                ),
                
            ],)
          ],
        ),
        
                  
               ],
      ),
    );
  }
}