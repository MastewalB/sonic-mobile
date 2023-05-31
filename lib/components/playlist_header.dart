import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class PlaylistHeader extends StatelessWidget {
  const PlaylistHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                alignment: Alignment.center,
                
                child: Image.asset(
                    'assets/images/album1.jpg',
                    fit: BoxFit.fill,
                    color: Colors.blue,
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
                ),
              ),
              Text(
                "Playlist",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "The biggest hits",
                  style: TextStyle(
                    
                    fontSize: 13,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              
          ],)
        ],
      ),
      
                Padding
                (padding: EdgeInsets.fromLTRB(25, 15, 0, 15),
                  
                    child: IconButton(
                      onPressed: (){},
                      icon: SvgPicture.asset('assets/icons/playbutton.svg',
                      color: Colors.white,),
                      iconSize: 60,
          ),
                  
                )
             ],
    );
  }
}