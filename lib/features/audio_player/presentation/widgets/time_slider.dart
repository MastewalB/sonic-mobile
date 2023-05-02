import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class TimeSlider extends StatefulWidget {
  const TimeSlider({Key? key}) : super(key: key);

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  double? _dragValue;
  bool _dragging = false;

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
      if (state.status.isFailure) {
        return const Center(child: Text("Playback Error"));
      } else if (state.status.isLoading || state.status.isInitial) {
        return Center(child: sliderPlaceholder());
      }
      return StreamBuilder(
        stream: audioPlayerBloc.fileDuration(),
        builder: (_, AsyncSnapshot<Duration> totalDurationSnapshot) =>
            StreamBuilder(
          stream: audioPlayerBloc.currentPosition(),
          builder: (_, AsyncSnapshot<Duration> snapshot) {
            // switch (snapshot.connectionState) {
            //   case ConnectionState.none:
            //     return sliderPlaceholder();
            //   case ConnectionState.done:
            //     return sliderPlaceholder();
            //   case ConnectionState.waiting:
            //     return sliderPlaceholder();
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.waiting) {
              if (snapshot.hasData && totalDurationSnapshot.hasData) {
                int seconds = snapshot.data!.inSeconds;
                Duration duration = snapshot.data!;
                Duration totalDuration = totalDurationSnapshot.data!;

                final value = min(
                  _dragValue ?? duration.inMilliseconds.toDouble(),
                  totalDuration.inMilliseconds.toDouble(),
                );

                if (_dragValue != null && !_dragging) {
                  _dragValue = null;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      SliderTheme(
                        data: const SliderThemeData(
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                          thumbColor: Colors.white,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 4.5,
                          ),
                          trackHeight: 3,
                        ),
                        child: Slider(
                          max: totalDuration.inMilliseconds.toDouble(),
                          value: value,
                          onChanged: (double value) {
                            if (!_dragging) {
                              _dragging = true;
                            }
                            setState(() {
                              _dragValue = value;
                            });
                            audioPlayerBloc.add(
                              SeekAudioEvent(
                                newPosition: Duration(
                                  milliseconds: value.toInt(),
                                ),
                              ),
                            );
                          },
                          onChangeEnd: (value) {
                            _dragging = false;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  ),
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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(
      children: [
        Slider(
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            value: 0,
            onChanged: (double value) {}),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
    ),
  );
}
