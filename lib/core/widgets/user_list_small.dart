import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/follow/bloc_stream/stream_bloc.dart';
import 'package:sonic_mobile/models/models.dart';

import '../../features/follow/bloc/follow_bloc.dart';

class UserListSmall extends StatelessWidget {
  final PublicUser user;

  const UserListSmall({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;

    double circleAvatarWidth = safeAreaWidth * 6;
    double trailingWidth = safeAreaWidth * 25;
    double sizedBoxWidth = trailingWidth * .01;
    Size buttonSize =
        Size(trailingWidth * 0.65, trailingWidth * 0.3); //width and height

    return ListTile(
      title: Text(
        user.fullName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      // subtitle: Text("7 Followers"),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: circleAvatarWidth,
            backgroundImage: const NetworkImage(
                "https://cdn.mos.cms.futurecdn.net/HjrVVsTBP8FfZoErpbWn4F-970-80.jpeg.webp"),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(80.0),
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      trailing: SizedBox(
        width: trailingWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {
                context.read<StreamBloc>().add(StartStreamEvent());
                context.read<AudioPlayerBloc>().connect(null);
              },
              child: const Text(
                "Join",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                maximumSize: MaterialStateProperty.all(buttonSize),
                minimumSize: MaterialStateProperty.all(buttonSize),
              ),
            ),
            SizedBox(
              width: sizedBoxWidth,
            ),
            // Icon(
            //   Icons.person_remove_sharp,
            //   color: Colors.red.shade200,
            // ),
          ],
        ),
      ),
    );
  }
}
