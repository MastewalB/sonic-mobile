import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marquee/marquee.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/follow/bloc/follow_bloc.dart';
import 'package:sonic_mobile/features/follow/bloc_stream/stream_bloc.dart';

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
                child:
                    // Image(
                    //   fit: BoxFit.cover,
                    //   height: 300,
                    //   width: 400,
                    //   gaplessPlayback: true,
                    //   image: (state.audioQueue!
                    //               .elementAt(state.currentIndex)
                    //               .imageUrl !=
                    //           null)
                    //       ?
                    CachedNetworkImage(
                  fit: BoxFit.cover,
                  errorWidget: (BuildContext context, _, __) => Container(
                    // fit: BoxFit.cover,
                    child: SvgPicture.asset('assets/icons/music-circle.svg'),
                  ),
                  placeholder: (BuildContext context, _) => Container(
                    // fit: BoxFit.cover,
                    color: Colors.black26,
                    child: SvgPicture.asset('assets/icons/music-circle.svg'),
                  ),
                  imageUrl:
                      state.audioQueue!.elementAt(state.currentIndex).imageUrl!,
                  height: 350,
                  width: 350,
                ),
                // NetworkImage(state.audioQueue!
                //         .elementAt(state.currentIndex)
                //         .imageUrl!) as ImageProvider
                // : const AssetImage(
                //     'assets/music_icon_image.jpg',
                //   ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (state.audioQueue!.isNotEmpty)
                    ? ("${state.audioQueue!.elementAt(state.currentIndex).title} - ${state.audioQueue!.elementAt(state.currentIndex).artistName}"
                                .length >
                            45)
                        ? Container(
                            constraints: const BoxConstraints(
                              maxHeight: 25,
                              maxWidth: 240,
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
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
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
                              state.audioQueue!
                                  .elementAt(state.currentIndex)
                                  .title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                    : const Text(""),
                BlocBuilder<StreamBloc, StreamState>(
                  builder: (context, streamState) {
                    return Container(
                      decoration: BoxDecoration(
                          color: (streamState is StreamSuccess)
                              ? Colors.green
                              : Colors.transparent,
                          border: Border.all(
                            color: Colors.green,
                          )),
                      child: IconButton(
                        onPressed: () {
                          if (streamState is StreamSuccess) {
                            context.read<StreamBloc>().add(StopStreamEvent());
                          } else {
                            context.read<StreamBloc>().add(StartStreamEvent());
                            context.read<AudioPlayerBloc>().connect(null);
                          }
                        },
                        icon: (streamState is StreamSuccess)
                            ? const Icon(
                                Icons.cell_tower,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.cell_tower_sharp,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
                fontSize: 15,
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
