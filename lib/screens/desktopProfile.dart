import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constants/colors.dart';
import '../features/profile.dart';
import '../features/responsive.dart';

class PlaylistInfoCard extends StatelessWidget {
  const PlaylistInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final PlaylistFile info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/playlist.png'),
                          radius: 100,
                        )
              ),
                          ],
          ),
          Text(
            info.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          
          
        ],
      ),
    );
  }
}


List demoPlaylistFiles = [
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "Leave your life",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "Go Crazy",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "Touch and go",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "Shape of you",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "Galway girl",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  PlaylistFile(
    icon: "assets/icons/menu_doc.svg",
    title: "XD File",
    album: "Subtract",
    date: "01-03-2021",
    duration: "3:15",
  ),
  
];
class DesktopProfile extends StatelessWidget {
  const DesktopProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
           Profile(),
          
          Expanded(child: 
            PlaylistLists())

          //Place to add the bottom dashboard
          
        ],
      ),
    ));
  }
}



class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 40, 0),
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurRadius: 1.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                            radius: 50,
                          ),
                        )),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Luhana Daniel",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  RichText(
                    selectionColor: Colors.white,
                    text: TextSpan(
                      text: ".8",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: ' Followers   ',
                          style: TextStyle(
                            fontFamily: 'courier',
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: '.13',
                          style: TextStyle(
                            fontFamily: 'courier',
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: ' Following',
                          style: TextStyle(
                            fontFamily: 'courier',
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}


       

  

class PlaylistLists extends StatelessWidget {
  const PlaylistLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding
            (
              padding: EdgeInsets.all(10),
              child: Text(
                
                "Playlists",
                style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: PlaylistInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: PlaylistInfoCardGridView(),
          desktop: PlaylistInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class PlaylistInfoCardGridView extends StatelessWidget {
  const PlaylistInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child:  ListView.builder(
                itemCount: demoPlaylistFiles.length,
                itemBuilder: (context, index) {
                  final playlist = demoPlaylistFiles[index];
                  return ListTile(
                    leading: Image.asset('assets/images/playlist.png'),
                    title: Text(playlist.title),
                    subtitle: Text('22 Songs',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 156, 163, 167),
                    ),),
                  );
                },
              ),
      );
    
  }
}