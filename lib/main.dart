import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/follow/presentation/followers_page.dart';
import 'package:sonic_mobile/models/AudioModelMock.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/player_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((value) => runApp(const MaterialApp(home: Sonic())));
}

class Sonic extends StatefulWidget {
  const Sonic({super.key});

  @override
  State<Sonic> createState() => _SonicState();
}

class _SonicState extends State<Sonic> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  void didChangeDependecies() {
    super.didChangeDependencies();
  }

  ListQueue<AudioMock> audioQueue = ListQueue<AudioMock>.from([
    const AudioMock(
      id: "id",
      language: "language",
      description: "Kings and Queens of Summer - Main",
      category: "Main Entrance",
      type: "type",
      thumbnail:
          "https://cdn.mos.cms.futurecdn.net/HjrVVsTBP8FfZoErpbWn4F-970-80.jpeg.webp",
      audio: "audio",
      audioUrl:
          "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Timelapse%20.mp3",
    ),
    const AudioMock(
      id: "id",
      language: "language",
      description: "Little Sunshine - But Solo",
      category: "Family",
      type: "type",
      thumbnail:
          "https://images.ecestaticos.com/xnNbBZp8-d8EtrRzQNEnUp3hOL4=/0x60:1919x1138/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fcc3%2F6d5%2F5eb%2Fcc36d55ebd0a8c375b6530ab68b0252b.jpg",
      audio: "audio",
      audioUrl:
          "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Little%20Sunshine%20-%20Solo.mp3",
    ),
    const AudioMock(
      id: "id2",
      language: "language",
      description: "Little Sunshine",
      category: "Family",
      type: "type",
      thumbnail:
          "https://www.hdwallpapers.in/download/life_2017_movie_4k-wide.jpg",
      audio: "audio",
      audioUrl:
          "https://github.com/MastewalB/competitive-programming/raw/master/Algorithms%20and%20Programming/Little%20Sunshine.mp3",
    )
  ]);

  @override
  Widget build(BuildContext context) {
    MediaQueryManager.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioPlayerBloc>(
          create: (context) => AudioPlayerBloc(audioPlayer: AudioPlayer())
            ..add(
              PlayAudioEvent(playlist: audioQueue, currentIndex: 0),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Sonic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlayerPage(),
      ),
    );
  }
}
