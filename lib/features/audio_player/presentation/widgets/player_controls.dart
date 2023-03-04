import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';


class PlayerControls extends StatefulWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    return BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
        builder: (_, state) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.skip_previous_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    audioPlayerBloc.add(PlayPreviousEvent());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    child: Icon(
                      (state.isPlaying)
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: Colors.white,
                      size: 60,
                    ),
                    onTap: () {
                      (state.isPlaying)
                          ? audioPlayerBloc.add(PauseAudioEvent())
                          : audioPlayerBloc.add(ResumeAudioEvent());
                    },
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.skip_next_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  onTap: () {
                    audioPlayerBloc.add(PlayNextEvent());
                  },
                )
              ],
            ),
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went wrong."),
              duration: Duration(seconds: 2),
            ));
          }
        });
  }
}
