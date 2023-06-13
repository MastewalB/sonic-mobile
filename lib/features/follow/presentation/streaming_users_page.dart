import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/widgets/widgets.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/follow/bloc/follow_bloc.dart';

class StreamingUsersPage extends StatelessWidget {
  static const String routeName = "streaming_users";

  const StreamingUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Online Friends",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    return BlocBuilder<FollowBloc, FollowState>(
      builder: (context, state) {
        if (state is FollowError) {
          return Scaffold(
            appBar: appBar,
            body: Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        if (state is StreamersLoaded) {
          if (state.users.isEmpty) {
            return Scaffold(
              appBar: appBar,
              body: Center(
                child: Text(
                  "No Streaming Friends",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: appBar,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){},
                    child: UserListSmall(
                      user: state.users[index],
                    ),
                  );
                },
                itemCount: state.users.length,
              ),
            ),
          );
        }
        return Scaffold(
          appBar: appBar,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
