import 'package:flutter/material.dart';

class PlayerAppBar extends StatelessWidget {
  const PlayerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_down,
              textDirection: TextDirection.ltr,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          Icon(
            Icons.more_horiz,
            textDirection: TextDirection.ltr,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
