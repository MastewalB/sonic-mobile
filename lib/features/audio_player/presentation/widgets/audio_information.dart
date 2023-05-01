import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class AudioInformation extends StatelessWidget {
  const AudioInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    final audioQueue = audioPlayerBloc.audioQueue;

    // debugPrint(audioPlayerBloc.audioQueue.length.toString());
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black45, blurRadius: 15)
              ]),
              child: Card(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child:
                      // audioQueue
                      //         .elementAt(state.currentIndex)
                      //         .fileUrl
                      //         .startsWith('file')
                      //     ?
                      Image(
                    fit: BoxFit.cover,
                    height: 350,
                    width: 400,
                    gaplessPlayback: true,
                    image: NetworkImage(
                        "https://images.ecestaticos.com/xnNbBZp8-d8EtrRzQNEnUp3hOL4=/0x60:1919x1138/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fcc3%2F6d5%2F5eb%2Fcc36d55ebd0a8c375b6530ab68b0252b.jpg"),

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
          SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              audioQueue.elementAt(state.currentIndex).title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              audioQueue.elementAt(state.currentIndex).artistName,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 18,
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
