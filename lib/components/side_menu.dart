import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:sonic_mobile/core/constants/colors.dart';
import 'package:sonic_mobile/features/library/presentation/library_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';

import '../features/studio/presentation/record_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer
    (
      backgroundColor: secondaryColor,
      child: SingleChildScrollView(
        child: Column(
          
        children:[
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),),
          DrawerListTile(
            title: "Home",
            svgSrc: "assets/images/home.svg",
            press:() {
              Navigator.pushNamed(
                  context,
                  RecordPage.routeName,
                );
            },
      
          ),
          DrawerListTile(
            title: "Search",
            svgSrc: "assets/icons/Search.svg",
            press:() {
              Navigator.pushNamed(
                  context,
                  LibraryPage.routeName,
                );
            },
      
          ),
          DrawerListTile(
            title: "Playlists",
            svgSrc: "assets/icons/Search.svg",
            press:() {},
      
          ),
          DrawerListTile(
            title: "My Files",
            svgSrc: "assets/icons/menu_doc.svg",
            press:() {},
      
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_doc.svg",
            press:() {},
      
          ),
          ],
                ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key, 
    required this.title, 
    required this.svgSrc, 
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(title,
       style:TextStyle(color: Colors.white54)),
    );
  }
}