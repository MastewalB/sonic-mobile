import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/widgets/root_scaffold.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';

class StudioLibrary extends StatefulWidget {
  static const String routeName = "my_studio";

  const StudioLibrary({Key? key}) : super(key: key);

  @override
  State<StudioLibrary> createState() => _StudioLibraryState();
}

class _StudioLibraryState extends State<StudioLibrary> {
  List<Widget> screens = [
    YourPodcastsPage(),
    Scaffold(),
  ];
  List<IconData> icons = [
    Icons.podcasts,
    Icons.home,
  ];
  List<String> names = [
    "Your Podcasts",
    "Another",
  ];

  @override
  Widget build(BuildContext context) {
    return RootScaffold(
      screens: screens,
      icons: icons,
      names: names,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider(
                        create: (context) => CreatePodcastBloc(
                            studioRepository:
                                DependencyProvider.getHttpStudioRepository()!),
                        child: const CreatePodcastPage(),
                      )));
        },
      ),
    );
  }
}
