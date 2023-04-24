import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final List<Widget> screens;
  final List<IconData> icons;
  final List<String> names;
  final void Function(int) callback;
  int selectedIndex;

  CustomBottomNavigationBar({
    Key? key,
    required this.screens,
    required this.icons,
    required this.names,
    this.selectedIndex = 0,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [];
    for (int i = 0; i < icons.length; i++) {
      bottomNavItems
          .add(BottomNavigationBarItem(icon: Icon(icons[i]), label: names[i]));
    }

    return BottomNavigationBar(
      elevation: 3,
      currentIndex: selectedIndex,
      items: bottomNavItems,
      onTap: callback,
    );
  }
}
