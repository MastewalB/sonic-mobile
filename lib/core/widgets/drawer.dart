import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatelessWidget {
  final List<Widget> drawerItems;

  const CustomDrawerWidget({
    Key? key,
    required this.drawerItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: drawerItems,
      ),
    );
  }
}
