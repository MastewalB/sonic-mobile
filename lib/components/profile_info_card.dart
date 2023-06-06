import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/colors.dart';
import '../models/files.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 140,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: Container(

  height: 150,
  alignment: Alignment.center,
  child: Image.asset(
        'assets/images/shay.jpeg',
        fit: BoxFit.contain,
        width: 350,
      ),
  
  ),
              ),
              //Icon(Icons.play_arrow_outlined, color: Colors.white54)
            ],
          ),
          Expanded(
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

