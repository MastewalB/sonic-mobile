import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final String profileName;

  const Header({Key? key, required this.profileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // SvgPicture.asset(
              //   'assets/logo.svg',
              //   height: 32.0,
              // ),
              const SizedBox(width: 8.0),
              const Text(
                'Sonic',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 8.0),
              Text(
                profileName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
