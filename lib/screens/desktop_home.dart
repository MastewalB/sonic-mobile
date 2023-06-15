import 'package:flutter/material.dart';
import 'package:sonic_mobile/components/follower_list.dart';
import 'package:sonic_mobile/components/home_song_lists.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'package:sonic_mobile/features/profile/presentation/widgets/profile_info.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/screens/desktop_playlist.dart';
import 'package:sonic_mobile/screens/home_page/homepage.dart';
import 'package:sonic_mobile/screens/profile_screen.dart';
import '../components/playlist_file.dart';
import '../components/storage_details.dart';
import '../core/constants/colors.dart';
import '../../components/header.dart';
import '../../components/my_files.dart';
import '../../components/recent_files.dart';
import '../../components/profile_lists.dart';

import 'package:sonic_mobile/routes.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "desktop_home";

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final PageRouter pageRouter = PageRouter();

  final _desktopHomePageKey = GlobalKey<NavigatorState>();
    final _recordPageKey = GlobalKey<NavigatorState>();

   Future<bool> _onHomeWillPop() async {
    if (_desktopHomePageKey.currentState != null) {
      _desktopHomePageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }

  Future<bool> _onRecordWillPop() async {
    if (_recordPageKey.currentState != null) {
      _recordPageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    List _pages = [
      WillPopScope(
            onWillPop: _onHomeWillPop,
            child: Navigator(
              key: _desktopHomePageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: DesktopHomePage.routeName,
            ),
          ),
       WillPopScope(
            onWillPop: _onRecordWillPop,
            child: Navigator(
              key: _recordPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: DesktopPlaylist.routeName,
            ),
          ),
      Container(),
      Container(),
    ];
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 55,
        
        child: BottomNavigationBar(
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 3,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart,
              ),
              label: "Library",
            ),
            
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_rounded,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
