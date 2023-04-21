import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/constants/constants.dart';
import 'package:sonic_mobile/models/models.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryManager.init(context);
    return MaterialApp(
      title: 'Sonic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(),
    );
  }
}
