import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:sonic_mobile/core/constants/constants.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'features/album/presentation/album_page.dart';
import 'features/album/presentation/widgets/album_art.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: const Sonic()));
  // SystemChrome.setPreferredOrientations(DeviceOrientation.portraitUp)
}

class Sonic extends StatefulWidget {
  const Sonic({super.key});

  @override
  State<Sonic> createState() => _SonicState();
}

class _SonicState extends State<Sonic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQueryManager.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: AlbumPage()),
    );
  }
}
