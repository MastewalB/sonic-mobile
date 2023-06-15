import 'package:flutter/material.dart';

class CardSmall extends StatelessWidget {
  final String title;
  final String duration;
  final String? image;
  final Color? color;
  final bool fromAsset;

  const CardSmall({
    Key? key,
    required this.title,
    required this.duration,
    this.image,
    this.color,
    this.fromAsset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Color.fromARGB(255, 31, 29, 43),
        color: Colors.transparent,
      ),
      height: 50,
      alignment: Alignment.center,
      child: Row(
        children: [
          (image != null)
              ? SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    child: (fromAsset)
                        ? Image.asset(
                            image!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(image!),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color ?? Colors.white,
                    fontSize: 16,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Flexible(
                  child: Text(
                    duration,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 211, 205, 205),
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
