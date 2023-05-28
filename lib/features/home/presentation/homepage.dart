// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/home/bloc/song/song_bloc.dart';
import 'package:sonic_mobile/features/home/repository/http_home_repository.dart';

import 'widgets/catchphrase.dart';
import 'widgets/header.dart';
import 'widgets/display_blocks.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songRepository = HomeDataProvider(httpClient: http.Client());
    return SafeArea(
        child: Column(
      children: [
        Header(
          profileName: 'Labile',
        ),
        CatchPhrase(
          text: "Are you Ready for some Music?",
        ),
        BlocProvider<SongBloc>(
          create: (context) => SongBloc(songRepository),
          child: DisplayBlock(
            desc: "Songs you may like",
          ),
        ),
      ],
    ));
  }
}
