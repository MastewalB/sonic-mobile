import 'package:flutter/material.dart';

class PlayerAppBar extends StatelessWidget {
  const PlayerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        child: const Icon(
          Icons.keyboard_arrow_down,
          textDirection: TextDirection.ltr,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        const Icon(
          Icons.more_horiz,
          textDirection: TextDirection.ltr,
          color: Colors.white,
        ),
      ],
    );
  }
}
