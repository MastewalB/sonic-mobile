import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/core.dart';

class UserListSmall extends StatelessWidget {
  const UserListSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;

    double circleAvatarWidth = safeAreaWidth * 8;
    double trailingWidth = safeAreaWidth * 25;
    double sizedBoxWidth = trailingWidth * .01;
    Size buttonSize = Size(trailingWidth * 0.65, trailingWidth * 0.3); //width and height

    return ListTile(
      title: Text(
        "Black Stone Cherry",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
      subtitle: Text("7 Followers"),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: circleAvatarWidth,
            backgroundImage: const NetworkImage(
                "https://cdn.mos.cms.futurecdn.net/HjrVVsTBP8FfZoErpbWn4F-970-80.jpeg.webp"),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(7.5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(90.0),
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      trailing: SizedBox(
        width: trailingWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Join",
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                maximumSize: MaterialStateProperty.all(buttonSize),
                minimumSize: MaterialStateProperty.all(buttonSize),
              ),
            ),
            SizedBox(
              width: sizedBoxWidth,
            ),
            Icon(
              Icons.person_remove_sharp,
              color: Colors.red.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
