import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';
// import 'package:sonic_mobile/features/studio/presentation/record_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/album/bloc/album/album_bloc.dart';
import 'features/album/repository/http_music_repository.dart';

void main() {
  final albumDataProvider = AlbumDataProvider(httpClient: http.Client());
  final albumBloc = AlbumBloc(albumDataProvider);
  WidgetsFlutterBinding.ensureInitialized();
  final PageRouter pageRouter = PageRouter();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight
  ]).then(
    (value) => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sonic',
        theme: CustomTheme.DarkTheme,
        home: BlocProvider(
          create: (context) => StudioBloc(
            studioRepository: DependencyProvider.getHttpStudioRepository()!,
          )..add(const GetAllPodcastsByUserEvent(userId: "userId")),
          child: Sonic(),
        ),
        onGenerateRoute: pageRouter.generateRoute,
      ),
    ),
  );
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
                        child: CreatePodcastPage(),
                      )));
        },
      ),
    );
  }
}
