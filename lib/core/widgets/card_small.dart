import 'package:flutter/material.dart';

class CardSmall extends StatelessWidget {
  final String title;
  final String duration;
  final String? image;

  const CardSmall({
    Key? key,
    required this.title,
    required this.duration,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 31, 29, 43),
      ),
      height: 50,
      alignment: Alignment.center,
      child: Row(
        children: [
          (image != null)
              ? Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
              ),
              Flexible(
                child: Text(
                  duration,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
