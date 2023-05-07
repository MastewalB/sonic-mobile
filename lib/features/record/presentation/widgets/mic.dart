import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/core.dart';


class Mic extends StatefulWidget {
  const Mic({Key? key}) : super(key: key);

  @override
  State<Mic> createState() => _MicState();
}

class _MicState extends State<Mic> {
  late double micSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQueryManager.safeAreaVertical;
    double safeAreaWidth = MediaQueryManager.blockSizeHorizontal;

    double micSize = min(safeAreaWidth, safeAreaHeight) * 65;

    double neomorphicOffset = 5;
    double micBlurRadius = 4;
    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffFD5D5D),
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                offset: Offset(2, 8),
                blurRadius: 5,
                spreadRadius: 5),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: neomorphicOffset,
              right: neomorphicOffset,
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  micIcon(
                    micSize: micSize,
                    color: const Color(0xffFF8080),
                  ),
                  ClipRRect(
                    // borderRadius: BorderRadius.circular(150),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: micBlurRadius,
                        sigmaY: micBlurRadius,
                        tileMode: TileMode.clamp,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: neomorphicOffset,
              left: neomorphicOffset,
              child: Stack(
                // fit: StackFit.expand,
                children: [
                  micIcon(
                    micSize: micSize,
                    color: Colors.black45,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: micBlurRadius,
                        sigmaY: micBlurRadius,
                        tileMode: TileMode.clamp,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            micIcon(micSize: micSize, color: const Color(0xffFD5D5D)),
          ],
        ),
      ),
    );
  }

  Widget micIcon({
    required double micSize,
    Color color = Colors.black12,
  }) {
    return Icon(
      Icons.mic_rounded,
      size: micSize,
      color: color,
    );
  }
}
