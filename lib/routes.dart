import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/features/studio/bloc/podcast_detail_bloc/podcast_detail_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/local_songs.dart';
import 'package:sonic_mobile/features/studio/presentation/podcast_detail_page.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/list_songs.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/update_podcast_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';

import 'features/audio_player/presentation/player_page.dart';
import 'features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';
import 'features/studio/bloc/record_bloc/record_bloc.dart';
import 'features/studio/presentation/record_page.dart';
import 'features/studio/presentation/widgets/create_episode_page.dart';

class PageRouter {
  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case FolderSongs.routeName:
        FolderSongsArguments folderSongsArguments =
            routeSettings.arguments as FolderSongsArguments;
        return MaterialPageRoute(builder: (context) {
          return FolderSongs(
            songs: folderSongsArguments.songs,
            folderName: folderSongsArguments.folderName,
          );
        });
      case LocalSongs.routeName:
        return MaterialPageRoute(builder: (context) {
          return const LocalSongs();
        });
      case PlayerPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return const PlayerPage();
        });
      case YourPodcastsPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => StudioBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!,
              notificationCubit: DependencyProvider.getNotificationCubit()!,
            )..add(const GetAllPodcastsByUserEvent(userId: "userId")),
            child: YourPodcastsPage(),
          );
        });
      case RecordingListPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => RecordBloc(
              notificationCubit: DependencyProvider.getNotificationCubit()!,
            )..add(
                ListRecordingsEvent(),
              ),
            child: const RecordingListPage(),
          );
        });
      case StudioLibrary.routeName:
        final StudioLibraryScreenArguments? studioLibraryScreenArguments =
            (routeSettings.arguments != null)
                ? routeSettings.arguments as StudioLibraryScreenArguments
                : null;
        int initialIndex = 0;
        initialIndex = ((studioLibraryScreenArguments != null)
            ? studioLibraryScreenArguments.initialIndex
            : 0)!;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => StudioBloc(
                    studioRepository:
                        DependencyProvider.getHttpStudioRepository()!,
                    notificationCubit:
                        DependencyProvider.getNotificationCubit()!,
                  )..add(const GetAllPodcastsByUserEvent(userId: "userId")),
                ),
                BlocProvider(
                  create: (context) => RecordBloc(
                    notificationCubit:
                        DependencyProvider.getNotificationCubit()!,
                  )..add(
                      ListRecordingsEvent(),
                    ),
                ),
              ],
              child: StudioLibrary(
                initialIndex: initialIndex,
              ),
            );
          },
        );
      case PodcastDetailPage.routeName:
        final PodcastScreenArgument podcastScreenArgument =
            routeSettings.arguments as PodcastScreenArgument;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => PodcastDetailBloc(
                studioRepository: DependencyProvider.getHttpStudioRepository()!,
                notificationCubit: DependencyProvider.getNotificationCubit()!,
              )..add(GetPodcastDetailEvent()),
              child: PodcastDetailPage(podcast: podcastScreenArgument.podcast),
            );
          },
        );
      case UpdatePodcastPage.routeName:
        final PodcastScreenArgument podcastScreenArgument =
            routeSettings.arguments as PodcastScreenArgument;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => PodcastDetailBloc(
                studioRepository: DependencyProvider.getHttpStudioRepository()!,
                notificationCubit: DependencyProvider.getNotificationCubit()!,
              ),
              child: UpdatePodcastPage(podcast: podcastScreenArgument.podcast),
            );
          },
        );
      case CreatePodcastPage.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => CreatePodcastBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!,
              notificationCubit: DependencyProvider.getNotificationCubit()!,
            ),
            child: const CreatePodcastPage(),
          ),
        );
        break;

      case RecordPage.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => RecordBloc(
              notificationCubit: DependencyProvider.getNotificationCubit()!,
            ),
            child: const RecordPage(),
          ),
        );

      case CreateEpisodePage.routeName:
        CreateEpisodeScreenArguments createEpisodeScreenArguments =
            routeSettings.arguments as CreateEpisodeScreenArguments;
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider(
            create: (context) => PodcastDetailBloc(
              studioRepository: DependencyProvider.getHttpStudioRepository()!,
              notificationCubit: DependencyProvider.getNotificationCubit()!,
            )..add(CreateEpisodeInitial()),
            child: CreateEpisodePage(
              podcast: createEpisodeScreenArguments.podcast,
            ),
          ),
        );
    }
    return null;
  }
}
