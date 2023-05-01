import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/widgets/widgets.dart';


class PlayerPage extends StatelessWidget {
  static const String routeName = "/player";
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    debugPrint(audioPlayerBloc.audioQueue.length.toString());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(Colors.grey.shade50.value),
              Color(Colors.grey.shade900.value),
              Color(Colors.black87.value),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: const [0.0, 0.7, 1.0],
            tileMode: TileMode.clamp,
          ),
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
