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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((value) => runApp(const MaterialApp(home: Sonic())));
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {

    });
  }

  @override
  void didChangeDependecies(){
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryManager.init(context);

    return MaterialApp(
      title: 'Sonic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: FollowersPage(),
      ),
    );
  }
}
