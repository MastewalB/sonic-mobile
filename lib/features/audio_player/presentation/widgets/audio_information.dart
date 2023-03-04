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
      builder: (_, state) =>
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   textDirection: TextDirection.ltr,
          //   children: [
          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: audioQueue
                        .elementAt(state.currentIndex)
                        .audioUrl
                        .startsWith('file')
                    ? Image(
                        fit: BoxFit.cover,
                        height: 300,
                        width: 300,
                        gaplessPlayback: true,
                        image: FileImage(File(Uri.parse(audioQueue
                                .elementAt(state.currentIndex)
                                .audioUrl)
                            .toFilePath())),
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        errorWidget: (BuildContext context, _, __) => Container(
                          // fit: BoxFit.cover,
                          child:
                              SvgPicture.asset('assets/icons/music-circle.svg'),
                        ),
                        placeholder: (BuildContext context, _) => Container(
                          // fit: BoxFit.cover,
            color: Colors.black26,
                          child:
                              SvgPicture.asset('assets/icons/music-circle.svg'),
                        ),
                        imageUrl:
                            audioQueue.elementAt(state.currentIndex).thumbnail,
                        height: 400,
                        width: 350,
                      ),
              ),
            ),
            // Image.network(
            //     "https://e0.pxfuel.com/wallpapers/807/950/desktop-wallpaper-life-2022-movie.jpg"
            //     // "${state.audioQueue?.elementAt(state.currentIndex).thumbnail}"
            //     ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
                // width: 100,
                // height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        audioQueue.elementAt(state.currentIndex).description,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        audioQueue.elementAt(state.currentIndex).category,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // GestureDetector(
      //   child: const Icon(
      //     Icons.file_download_done_outlined,
      //     color: Colors.black,
      //     textDirection: TextDirection.ltr,
      //   ),
      //   onTap: () {},
      // )
      //   ],
      // ),
    );
  }
}
