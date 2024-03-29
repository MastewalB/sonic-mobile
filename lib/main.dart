import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:flutter/services.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/studio/bloc/record_bloc/record_bloc.dart';
import 'package:sonic_mobile/features/studio/presentation/studio_library.dart';
import 'package:sonic_mobile/dependency_provider.dart';
import 'package:sonic_mobile/routes.dart';
import 'features/auth/blocs/signup_bloc/signup_bloc.dart';
import 'features/auth/models/user_profile.dart';
import 'features/studio/bloc/studio_bloc/studio_bloc.dart';
import 'package:sonic_mobile/features/auth/auth.dart';

void main() async {
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
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<NotificationCubit, NotificationState>(
                listener: (context, state) {
              Color? color = (state is NotificationSuccess)
                  ? Colors.green.shade300
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
        userProfileRepository:
        DependencyProvider.getUserProfileRepository()!,
        secureStorage: DependencyProvider.getSecureStorage()!,
      ),
      child: const SignUpPage(),
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
