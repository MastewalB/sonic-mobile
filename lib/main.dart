import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:sonic_mobile/core/constants/constants.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'features/album/presentation/album_page.dart';
import 'features/album/presentation/widgets/album_art.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/core/widgets/root_scaffold.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: const Sonic()));
  // SystemChrome.setPreferredOrientations(DeviceOrientation.portraitUp)
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
        home: const Sonic(),
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
    return MaterialApp(
      title: 'Sonic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: Homepage()),
    MediaQueryManager.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudioBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!)
            ..add(const GetAllPodcastsByUserEvent(userId: "userId")),
        ),
        BlocProvider(
          create: (context) => RecordBloc()..add(ListRecordingsEvent()),
        ),
      ],
      child: const StudioLibrary(),
    );
    ;
  }
}
