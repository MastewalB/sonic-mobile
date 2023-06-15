import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/features/album/presentation/album_page.dart';
import 'package:sonic_mobile/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'package:sonic_mobile/features/library/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';

// import 'package:sonic_mobile/features/studio/presentation/record_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/profile.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'package:sonic_mobile/screens/desktopProfile.dart';
import 'package:sonic_mobile/screens/desktop_home.dart';
import 'package:sonic_mobile/screens/desktop_playlist.dart';
import 'package:sonic_mobile/screens/profile_screen.dart';
import 'package:sonic_mobile/screens/recording_screen.dart';
import 'package:window_size/window_size.dart';
import 'components/side_menu.dart';
import 'features/auth/blocs/signup_bloc/signup_bloc.dart';
import 'features/auth/models/user_profile.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/auth/auth.dart';
import 'dart:io' as io;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (io.Platform.isWindows ) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(1000, 1000));
    setWindowMaxSize(Size.infinite);
  }
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(UserProfileAdapter());
  final PageRouter pageRouter = PageRouter();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final NotificationCubit notificationCubit =
      DependencyProvider.getNotificationCubit()!;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => notificationCubit,
          ),
          BlocProvider(
            create: (context) => AudioPlayerBloc(
              audioPlayer: DependencyProvider.getAudioPlayer()!,
            ),
          ),
          BlocProvider(
              create: (context) => ProfileBloc(
                    userProfileRepository:
                        DependencyProvider.getUserProfileRepository()!,
                    secureStorage: DependencyProvider.getSecureStorage()!,
                  )),
          BlocProvider(
              create: (context) => PlaylistBloc(
                  libraryRepository:
                      DependencyProvider.getHttpLibraryProvider()!,
                  notificationCubit: notificationCubit))
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<NotificationCubit, NotificationState>(
                listener: (context, state) {
              Color? color = (state is NotificationSuccess)
                  ? Colors.blue
                  : (state is NotificationError)
                      ? Colors.red.shade500
                      : null;

              if (state is NotificationSuccess ||
                  state is NotificationError ||
                  state is NotificationInfo) {
                messengerKey.currentState!.hideCurrentSnackBar();
                messengerKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    duration: const Duration(seconds: 10),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: color,
                    action: (state.action != null)
                        ? SnackBarAction(
                            label: state.actionMessage!,
                            onPressed: state.action!,
                          )
                        : SnackBarAction(
                            label: "Close",
                            textColor: Colors.white,
                            onPressed: () => messengerKey.currentState!
                                .hideCurrentSnackBar(),
                          ),
                  ),
                );
                notificationCubit.notificationInitital();
                return;
              }
            }),
          ],
          child: MaterialApp(
            scaffoldMessengerKey: messengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Sonic',
            theme: CustomTheme.DarkTheme,
            home: const Sonic(),
            onGenerateRoute: pageRouter.generateRoute,
          ),
        ),
      ),
    ),
  );
}

class Sonic extends StatefulWidget {
  const Sonic({super.key});

  @override
  State<Sonic> createState() => _SonicState();
}

class _SonicState extends State<Sonic> with WidgetsBindingObserver {
  final double minScreenWidth = 1500;
  bool resized = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependecies() {
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryManager.init(context);

    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository:
            DependencyProvider.getHttpAuthenticationRepository()!,
        notificationCubit: DependencyProvider.getNotificationCubit()!,
        userProfileRepository: DependencyProvider.getUserProfileRepository()!,
        secureStorage: DependencyProvider.getSecureStorage()!,
      )..add(LoginInitialEvent()),
      child: const DashboardScreen(),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => StudioBloc(
    //         studioRepository: DependencyProvider.getHttpStudioRepository()!,
    //         notificationCubit: DependencyProvider.getNotificationCubit()!,
    //       )..add(const GetAllPodcastsByUserEvent(userId: "userId")),
    //     ),
    //     BlocProvider(
    //       create: (context) => RecordBloc(
    //         notificationCubit: DependencyProvider.getNotificationCubit()!,
    //       )..add(ListRecordingsEvent()),
    //     ),
    //   ],
    //   child: const StudioLibrary(),
    // );
  }
}
