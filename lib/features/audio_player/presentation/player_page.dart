import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/widgets/widgets.dart';

import '../../../models/AudioModelMock.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

  debugPrint(audioPlayerBloc.audioQueue.length.toString());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: ListView(
          children: const [
            PlayerAppBar(),
            AudioInformation(),
            TimeSlider(),
            PlayerControls(),
          ],
        ),
      ),
    );
  }
}
