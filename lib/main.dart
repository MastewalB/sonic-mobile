import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/core/widgets/root_scaffold.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';

import 'package:sonic_mobile/features/studio/repository/http_studio_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';

void main() {
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
    MediaQueryManager.init(context);

    return BlocProvider(
      create: (context) => StudioBloc(
          studioRepository: DependencyProvider.getHttpStudioRepository()!)
        ..add(GetAllPodcastsByUserEvent(userId: "userId")),
      child: StudioLibrary(),
    );
    ;
  }
}
