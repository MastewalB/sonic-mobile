
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/FollowerLists.dart';
import '../core/constants/colors.dart';

class FollowerInfoCard extends StatelessWidget {
  const FollowerInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final FollowerInfo info;

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
                padding: EdgeInsets.all(defaultPadding * 0.75),
                
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                ),
                child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/users.jpeg'),
                          radius: 65,
                        ),
              ),
                          ],
          ),
          Text(
            info.username!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "Profile",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          
          
        ],
      ),
    );
  }
}


