import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/widgets/widgets.dart';

import '../../../components/follower_list.dart';
import '../../../components/profile_header.dart';
import '../../../components/profile_lists.dart';
import '../../../core/constants/colors.dart';


class PlayerPage extends StatelessWidget {
  static const String routeName = "/player";
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    debugPrint(audioPlayerBloc.audioQueue.length.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        elevation: 20,
        shadowColor: const Color.fromARGB(255, 100, 100, 100),
        leading: GestureDetector(
          child: const Icon(
            Icons.keyboard_arrow_down,
            textDirection: TextDirection.ltr,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            textDirection: TextDirection.ltr,
            color: Colors.white,
          ),
        ],
      ),
      body: SafeArea(
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
    ),
    );
  }
}
