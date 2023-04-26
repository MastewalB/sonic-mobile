import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/studio/bloc/podcast_detail_bloc/podcast_detail_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/update_podcast_page.dart';

class PageRouter {
  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case StudioLibrary.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => StudioBloc(
                studioRepository: DependencyProvider.getHttpStudioRepository()!)
              ..add(const GetAllPodcastsByUserEvent(userId: "userId")),
            child: const StudioLibrary(),
          );
        });
      case PodcastDetailPage.routeName:
        final PodcastScreenArgument podcastScreenArgument =
            routeSettings.arguments as PodcastScreenArgument;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => PodcastDetailBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!,
            ),
            child: PodcastDetailPage(podcast: podcastScreenArgument.podcast),
          );
        });
      case UpdatePodcastPage.routeName:
        final PodcastScreenArgument podcastScreenArgument =
            routeSettings.arguments as PodcastScreenArgument;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => PodcastDetailBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!,
            ),
            child: UpdatePodcastPage(podcast: podcastScreenArgument.podcast),
          );
        });
    }
    return null;
  }
}
