import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/profile/presentation/widgets/profile_info.dart';
import 'responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistInfoCard extends StatelessWidget {
  const PlaylistInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final PlaylistFile info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        color: Constants.secondaryColor,
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
                  padding: EdgeInsets.all(Constants.defaultPadding * 0.75),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/playlist.png'),
                    radius: 100,
                  )),
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

///to be deleted when correctly replaced
class PlaylistFile {
  final String? icon, title, album, date, duration;

  PlaylistFile({this.icon, this.title, this.album, this.date, this.duration});
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

class ProfilePage extends StatelessWidget {
  static const String routeName = "profile";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: const [
          Profile(),

          // const Expanded(child: PlaylistLists())

          //Place to add the bottom dashboard
        ],
      ),
    ));
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
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Playlists",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Constants.defaultPadding),
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
      child: ListView.builder(
        itemCount: demoPlaylistFiles.length,
        itemBuilder: (context, index) {
          final playlist = demoPlaylistFiles[index];
          return ListTile(
            leading: Image.asset('assets/images/playlist.png'),
            title: Text(
              playlist.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              '22 Songs',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 156, 163, 167),
              ),
            ),
          );
        },
      ),
    );
  }
}
