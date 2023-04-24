import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/record/presentation/widgets/mic.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Mic()),
    );
  }
}
