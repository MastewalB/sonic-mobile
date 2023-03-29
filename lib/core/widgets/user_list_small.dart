import 'package:flutter/material.dart';

class UserListSmall extends StatelessWidget {
  const UserListSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Black Stone", style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500
      ),),
      subtitle: Text("7 Followers"),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(
            "https://cdn.mos.cms.futurecdn.net/HjrVVsTBP8FfZoErpbWn4F-970-80.jpeg.webp"),
      ),
      trailing: SizedBox(
        width: 100,
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
                maximumSize: MaterialStateProperty.all(Size(55, 25)),
                minimumSize: MaterialStateProperty.all(Size(55, 25)),
              ),
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
