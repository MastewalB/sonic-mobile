import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:sonic_mobile/core/core.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Playlists'),
    ),
    Center(
      child: Text('Profile'),
    ),
    Center(
      child: Text('Settings'),
    ),

  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5,40,5,0),
        child: Container(
          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: thirdColor, // Replace with your desired color
    border: Border.all(
      color: thirdColor,
      
    ),),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16), 
                child: SideNavigationBar(
                  selectedIndex: selectedIndex,
                  items: const [
                    SideNavigationBarItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.person,
                      label: 'Playlists',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.person,
                      label: 'Profile',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.settings,
                      label: 'Settings',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  toggler: SideBarToggler(
                      expandIcon: Icons.keyboard_arrow_left,
                      shrinkIcon: Icons.keyboard_arrow_right,
                      onToggle: () {
                        print('Toggle');
                      }),
                ),
              ),
              Expanded(
                child: views.elementAt(selectedIndex),
              )
            ],
          ),
        ),
      ),
    );
  }
}