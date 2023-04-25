import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';

class PageRouter {
  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case StudioLibrary.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => StudioBloc(
                studioRepository: DependencyProvider.getHttpStudioRepository()!)
              ..add(GetAllPodcastsByUserEvent(userId: "userId")),
            child: StudioLibrary(),
          );
        });
    }
  }
}
