import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/follow/presentation/followers_page.dart';
import 'package:sonic_mobile/models/AudioModelMock.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/player_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AudioMock audio = const AudioMock(
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
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioPlayerBloc>(
          create: (context) => AudioPlayerBloc(audioPlayer: AudioPlayer())
            ..add(PlayAudioEvent(audio: audio)),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: FollowersPage(),
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
