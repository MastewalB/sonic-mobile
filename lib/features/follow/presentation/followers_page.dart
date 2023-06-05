import 'package:flutter/material.dart';
import 'package:sonic_mobile/core/widgets/widgets.dart';
import 'package:sonic_mobile/core/core.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, __) {
        return const UserListSmall();
      },
      itemCount: 6,
    );
  }
}
