import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/features/album/presentation/album_page.dart';
import 'package:sonic_mobile/features/auth/blocs/login_bloc/login_bloc.dart';
import 'package:sonic_mobile/features/follow/bloc/follow_bloc.dart';
import 'package:sonic_mobile/features/follow/bloc_stream/stream_bloc.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'package:sonic_mobile/features/library/bloc/playlist_bloc/playlist_bloc.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/create_podcast_bloc/create_podcast_bloc.dart';

// import 'package:sonic_mobile/features/studio/presentation/record_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/create_podcast_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/library/bloc/library_bloc/library_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/library_page.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'features/auth/blocs/signup_bloc/signup_bloc.dart';
import 'features/auth/models/user_profile.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/album/bloc/album/album_bloc.dart';
import 'features/album/repository/http_music_repository.dart';
import 'package:sonic_mobile/features/auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
              userProfileRepository:
                  DependencyProvider.getUserProfileRepository()!,
              audioPlayer: DependencyProvider.getAudioPlayer()!,
              channel: WebSocketChannel.connect(
                Uri.parse("${Constants.connectStreamUrl}stream/"),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              userProfileRepository:
                  DependencyProvider.getUserProfileRepository()!,
              secureStorage: DependencyProvider.getSecureStorage()!,
            ),
          ),
          BlocProvider(
            create: (context) => PlaylistBloc(
                libraryRepository: DependencyProvider.getHttpLibraryProvider()!,
                notificationCubit: notificationCubit),
          ),
          BlocProvider(
            create: (context) => FollowBloc(
                followRepository: DependencyProvider.getHttpFollowProvider()!,
                userProfileRepository:
                    DependencyProvider.getUserProfileRepository()!),
          ),
          BlocProvider(
            create: (context) => StreamBloc(
              followRepository: DependencyProvider.getHttpFollowProvider()!,
              userProfileRepository:
                  DependencyProvider.getUserProfileRepository()!,
            ),
          )
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

class _SonicState extends State<Sonic> {
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
      create: (context) => SignupBloc(
        authenticationRepository:
            DependencyProvider.getHttpAuthenticationRepository()!,
        notificationCubit: DependencyProvider.getNotificationCubit()!,
        userProfileRepository: DependencyProvider.getUserProfileRepository()!,
        secureStorage: DependencyProvider.getSecureStorage()!,
      )..add(SignUpInitialEvent()),
      child: const SignUpPage(),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => LibraryBloc(
    //         libraryRepository: DependencyProvider.getHttpLibraryProvider()!,
    //         userProfileRepository:
    //             DependencyProvider.getUserProfileRepository()!,
    //         notificationCubit: DependencyProvider.getNotificationCubit()!,
    //       )..add(GetAllPlaylistsByUser()),
    //     ),
    //   ],
    //   child: const LibraryPage(),
    // );
  }
}
