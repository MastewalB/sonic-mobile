import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/colors.dart';
import '../models/files.dart';

class HomeSongInfoCard extends StatelessWidget {
  const HomeSongInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:EdgeInsets.fromLTRB(defaultPadding * 0.12, defaultPadding * 0.12, defaultPadding * 0.12, 0),
                
                height: 143,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/shay.jpeg',
                    fit: BoxFit.fill,
                    width: 250,
                  ),
                ),
              ),
              //Icon(Icons.play_arrow_outlined, color: Colors.white54)
            ],
          ),
          Padding(
            padding:EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: Text(
              info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
