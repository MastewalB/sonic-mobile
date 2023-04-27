import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/widgets/root_scaffold.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/record_page.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';

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
  List<Widget> screens = [
    YourPodcastsPage(),
    const RecordingListPage(),
  ];
  List<IconData> icons = [
    Icons.podcasts,
    Icons.mic,
  ];
  List<String> names = [
    "Your Podcasts",
    "Record",
  ];

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
      screens: screens,
      icons: icons,
      names: names,
      initialIndex: widget.initialIndex,
      floatingActions: [
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (context) => CreatePodcastBloc(
                      studioRepository:
                          DependencyProvider.getHttpStudioRepository()!),
                  child: const CreatePodcastPage(),
                ),
              ),
            );
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (context) => RecordBloc(),
                  child: const RecordPage(),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
