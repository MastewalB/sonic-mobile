import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/constants/constants.dart';

void main() {
  runApp(const Sonic());
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
    MediaQueryManager.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(),
    );
  }
}
