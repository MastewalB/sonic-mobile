import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/core.dart';

class AudioVisualizer extends StatelessWidget {
  AudioVisualizer({required this.amplitude}) {
    ///limit amplitude to [decibleLimit]
    double db = amplitude ?? Constants.decibleLimit;
    if (db == double.infinity || db < Constants.decibleLimit) {
      db = Constants.decibleLimit;
    }
    if (db > 0) {
      db = 0;
    }

    ///this expression converts [db] to [0 to 1] double
    range = 1 - (db * (1 / Constants.decibleLimit));

  }
  final double? amplitude;
  final double maxHeight = 100;

  late final double range;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildBar(1.15),
        buildBar(1.5),
        buildBar(1.25),
        buildBar(1.75),
        buildBar(1),
        buildBar(3),
        buildBar(1),
        buildBar(1.75),
        buildBar(1.25),
        buildBar(1.5),
        buildBar(1.15),
      ],
    );
  }

  buildBar(double intensity) {
    double barHeight = range * maxHeight * intensity;
    if (barHeight < 5) {
      barHeight = 5;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: Constants.amplitudeCaptureRateInMilliSeconds,
        ),
        height: barHeight,
        width: 5,
        decoration: BoxDecoration(
          color: const Color(0xffFD5D5D),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: SonicColors.shadowColor,
              spreadRadius: 1,
              offset: Offset(1, 1),
            ),
            BoxShadow(
              color: SonicColors.highlightColor,
              spreadRadius: 1,
              offset: Offset(-1, -1),
            ),
          ],
        ),
      ),
    );
  }
}