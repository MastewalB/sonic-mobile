import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';


class TimeSlider extends StatefulWidget {
  const TimeSlider({Key? key}) : super(key: key);

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  String _getFormattedTime(Duration duration) {
    String twoDigits(int num) => num.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours.toInt() > 0) {
      return "${twoDigits(duration.inHours)}:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(builder: (_, state) {
      print(state.status);
      if (state.status.isFailure) {
        return Center(child: Text("Playback Error"));
      } else if (state.status.isLoading || state.status.isInitial) {
        return CircularProgressIndicator(color: Colors.blueGrey);
      }
      return StreamBuilder(
        stream: audioPlayerBloc.fileDuration(),
        builder: (_, AsyncSnapshot<Duration> totalDurationSnapshot) =>
            StreamBuilder(
          stream: audioPlayerBloc.currentPosition(),
          builder: (_, AsyncSnapshot<Duration> snapshot) {
            debugPrint(snapshot.toString() +
                " " +
                snapshot.hasData.toString() +
                " " +
                snapshot.data.toString());
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return sliderPlaceholder();
              case ConnectionState.active:
                return sliderPlaceholder();
              case ConnectionState.done:
                return sliderPlaceholder();
              case ConnectionState.waiting:
                if (snapshot.hasData && totalDurationSnapshot.hasData) {
                  int seconds = snapshot.data!.inSeconds;
                  Duration duration = snapshot.data!;
                  Duration totalDuration = totalDurationSnapshot.data!;

                  return Column(
                    children: [
                      Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          max: totalDuration.inSeconds.toDouble(),
                          value: seconds.toDouble(),
                          onChanged: (double value) {
                            audioPlayerBloc.add(
                              SeekAudioEvent(
                                newPosition: Duration(
                                  seconds: value.toInt(),
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getFormattedTime(duration),
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              _getFormattedTime(totalDuration),
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
            }

            return sliderPlaceholder();
          },
        ),
      );
    });
  }
}

Widget sliderPlaceholder() {
  return Column(
    children: [
      Slider(
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          value: 0,
          onChanged: (double value) {}),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "00:00",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "00:00",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      )
    ],
  );
}
