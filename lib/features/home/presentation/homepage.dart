import 'package:flutter/material.dart';

import 'widgets/catchphrase.dart';
import 'widgets/header.dart';
import 'widgets/display_blocks.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: const [
        Header(
          profileName: 'Labile',
        ),
        CatchPhrase(
          text: "Are you Ready for somme Music?",
        ),
        DisplayBlock(
          desc: "Songs you like",
          songs: [],
        )
      ],
    ));
  }
}
