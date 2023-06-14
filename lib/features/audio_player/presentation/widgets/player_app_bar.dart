import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_player_bloc.dart';

class PlayerAppBar extends StatelessWidget {
  const PlayerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, state) {
        return AppBar(
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
          title: Text(
            state.audioQueue!
                .elementAt(
              state.currentIndex,
            )
                .title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: const [
            Icon(
              Icons.more_vert,
              textDirection: TextDirection.ltr,
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }
}
