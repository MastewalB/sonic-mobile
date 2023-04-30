import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/routes.dart';

class StudioLibrary extends StatefulWidget {
  static const String routeName = "my_studio";
  final int initialIndex;

  const StudioLibrary({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<StudioLibrary> createState() => _StudioLibraryState();
}

class _StudioLibraryState extends State<StudioLibrary> {
  int _selectedIndex = 0;
  final PageRouter pageRouter = PageRouter();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  final _yourPodcastPageKey = GlobalKey<NavigatorState>();
  final _recordPageKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPop() async {
    if (_yourPodcastPageKey.currentState != null) {
      _yourPodcastPageKey.currentState!.maybePop();
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _yourPodcastPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: YourPodcastsPage.routeName,
            ),
          ),
          WillPopScope(
            onWillPop: _onRecordWillPop,
            child: Navigator(
              key: _recordPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: RecordingListPage.routeName,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.podcasts,
            ),
            label: "Your Podcasts",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic,
            ),
            label: "Recording",
          ),
        ],
      ),
    );
  }
}
