import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class AudioInformation extends StatelessWidget {
  const AudioInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    final audioQueue = audioPlayerBloc.audioQueue;

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (_, state) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black45, blurRadius: 15)
              ]),
              child: Card(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    fit: BoxFit.cover,
                    height: 300,
                    width: 400,
                    gaplessPlayback: true,
                    image: (state.audioQueue!
                                .elementAt(state.currentIndex)
                                .imageUrl !=
                            null)
                        ? NetworkImage(state.audioQueue!
                            .elementAt(state.currentIndex)
                            .imageUrl!) as ImageProvider
                        : const AssetImage(
                            'assets/music_icon_image.jpg',
                          ),
                  )
                  // : CachedNetworkImage(
                  //     fit: BoxFit.cover,
                  //     errorWidget: (BuildContext context, _, __) => Container(
                  //       // fit: BoxFit.cover,
                  //       child:
                  //           SvgPicture.asset('assets/icons/music-circle.svg'),
                  //     ),
                  //     placeholder: (BuildContext context, _) => Container(
                  //       // fit: BoxFit.cover,
                  //       color: Colors.black26,
                  //       child:
                  //           SvgPicture.asset('assets/icons/music-circle.svg'),
                  //     ),
                  //     imageUrl:
                  //         audioQueue.elementAt(state.currentIndex).thumbnail,
                  //     height: 350,
                  //     width: 350,
                  //   ),
                  ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: (state.audioQueue!.isNotEmpty)
                ? ("${state.audioQueue!.elementAt(state.currentIndex).title} - ${state.audioQueue!.elementAt(state.currentIndex).artistName}"
                            .length >
                        45)
                    ? Container(
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 400,
                        ),
                        child: Marquee(
                          text: state.audioQueue!
                              .elementAt(
                                state.currentIndex,
                              )
                              .title,
                          //state.audioQueue!.elementAt(state.currentIndex).id,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700),
                          pauseAfterRound: const Duration(seconds: 5),
                          blankSpace: 30.0,
                          scrollAxis: Axis.horizontal,
                          accelerationDuration: const Duration(seconds: 1),
                          velocity: 30.0,
                        ),
                      )
                    : Container(
                        constraints: const BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 400,
                        ),
                        child: Text(
                          state.audioQueue!.elementAt(state.currentIndex).title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                : const Text(""),
          ),
          const SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              audioQueue.elementAt(state.currentIndex).artistName,
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
