import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/player_page.dart';
import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/audio_player/presentation/widgets/time_slider.dart';
import 'package:sonic_mobile/features/studio/presentation/local_songs.dart';
import 'package:sonic_mobile/features/studio/presentation/recording_list_page.dart';
import 'package:sonic_mobile/features/studio/presentation/widgets/your_podcasts.dart';
import 'package:sonic_mobile/routes.dart';

class StudioLibrary extends StatefulWidget {
  static const String routeName = "my_studio";
  final int initialIndex;

  const StudioLibrary({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<StudioLibrary> createState() => _StudioLibraryState();
}

class _StudioLibraryState extends State<StudioLibrary> {
  int _selectedIndex = 0;
  final PageRouter pageRouter = PageRouter();

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  final _yourPodcastPageKey = GlobalKey<NavigatorState>();
  final _recordPageKey = GlobalKey<NavigatorState>();
  final _localSongsPageKey = GlobalKey<NavigatorState>();

  Future<bool> _onWillPop() async {
    if (_yourPodcastPageKey.currentState != null) {
      _yourPodcastPageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }

  Future<bool> _onRecordWillPop() async {
    if (_recordPageKey.currentState != null) {
      _recordPageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }

  Future<bool> _onLocalSongsWillPop() async {
    if (_localSongsPageKey.currentState != null) {
      _localSongsPageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    final TextStyle miniPlayerTitleStyle =
        TextStyle(color: Colors.white, fontSize: 15);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
              key: _yourPodcastPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: YourPodcastsPage.routeName,
            ),
          ),
          WillPopScope(
            onWillPop: _onRecordWillPop,
            child: Navigator(
              key: _recordPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: RecordingListPage.routeName,
            ),
          ),
          WillPopScope(
            onWillPop: _onLocalSongsWillPop,
            child: Navigator(
              key: _localSongsPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: LocalSongs.routeName,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          return SizedBox(
            // height: 140,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: state.isPlaying,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 35, 35, 45)),
                    child: SizedBox(
                      // height: 58,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                  image: (state.status.isLoading ||
                                          state.status.isInitial ||
                                          state.status.isFailure)
                                      ? const DecorationImage(
                                          image: AssetImage(
                                            'assets/music_icon_image.jpg',
                                          ),
                                        )
                                      : const DecorationImage(
                                          image: AssetImage(
                                            'assets/music_icon_image.jpg',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                constraints: const BoxConstraints(
                                  // maxHeight: 60,
                                  minHeight: 60,
                                  maxWidth: 60,
                                ),
                              ),
                              title: Container(
                                constraints: BoxConstraints(
                                    maxHeight: 60, maxWidth: 150),
                                child: (state.audioQueue!.isNotEmpty)
                                    ? ("${state.audioQueue!.elementAt(state.currentIndex).title} - ${state.audioQueue!.elementAt(state.currentIndex).artistName}"
                                                .length >
                                            30)
                                        ? Marquee(
                                            text:
                                                "${state.audioQueue!.elementAt(state.currentIndex).title} - ${state.audioQueue!.elementAt(state.currentIndex).artistName}",
                                            //state.audioQueue!.elementAt(state.currentIndex).id,
                                            style: miniPlayerTitleStyle,
                                            pauseAfterRound:
                                                Duration(seconds: 3),
                                            blankSpace: 20.0,
                                            scrollAxis: Axis.horizontal,
                                            accelerationDuration:
                                                Duration(seconds: 1),
                                            velocity: 30.0,
                                          )
                                        : Text(
                                            "${state.audioQueue!.elementAt(state.currentIndex).title} - ${state.audioQueue!.elementAt(state.currentIndex).artistName}",
                                            style: miniPlayerTitleStyle,
                                          )
                                    : Text(""),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    child: (state.status.isLoading)
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Icon(
                                            (state.status.isPlaying)
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                    onTap: () {
                                      (state.audioPlayer.state.name ==
                                              "PLAYING")
                                          ? audioPlayerBloc
                                              .add(PauseAudioEvent())
                                          : audioPlayerBloc
                                              .add(ResumeAudioEvent());
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    color: Colors.white,
                                    onPressed: () {
                                      context
                                          .read<AudioPlayerBloc>()
                                          .add(StopAudioEvent());
                                    },
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, PlayerPage.routeName);
                              }
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // children: [
                              //   InkWell(
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: [
                              //
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //       ],
                              //     ),
                              //     onTap: () {
                              //       Navigator.pushNamed(context, PlayerPage.routeName);
                              //     },
                              //   ),
                              //   GestureDetector(
                              //       onTap: () {
                              //         audioPlayerBloc.add(PlayPreviousEvent());
                              //       },
                              //       child: Icon(
                              //         Icons.skip_previous_rounded,
                              //         color: Colors.white,
                              //         size: 40,
                              //       )),
                              //
                              //   GestureDetector(
                              //       onTap: () {
                              //         audioPlayerBloc.add(PlayNextEvent());
                              //       },
                              //       child: Icon(
                              //         Icons.skip_next_rounded,
                              //         color: Colors.white,
                              //         size: 40,
                              //       )),
                              //
                              // ],
                              ),
                          Positioned(
                            top: -24,
                            child: StreamBuilder(
                              stream: audioPlayerBloc.fileDuration(),
                              builder: (_,
                                      AsyncSnapshot<Duration>
                                          totalDurationSnapshot) =>
                                  StreamBuilder(
                                stream: audioPlayerBloc.currentPosition(),
                                builder: (_, AsyncSnapshot<Duration> snapshot) {
                                  // debugPrint(snapshot.connectionState.name);
                                  // switch (snapshot.connectionState) {
                                  // case ConnectionState.none:
                                  //   return sliderPlaceholder();
                                  // case ConnectionState.waiting:
                                  //   return sliderPlaceholder();
                                  // case ConnectionState.done:
                                  //   return sliderPlaceholder();
                                  if (snapshot.connectionState ==
                                          ConnectionState.active ||
                                      snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                    if (snapshot.hasData &&
                                        totalDurationSnapshot.hasData) {
                                      int seconds = snapshot.data!.inSeconds;
                                      Duration duration = snapshot.data!;
                                      Duration totalDuration =
                                          totalDurationSnapshot.data!;

                                      final value = min(
                                          duration.inMilliseconds.toDouble(),
                                          totalDuration.inMilliseconds
                                              .toDouble());

                                      return SliderTheme(
                                        data: const SliderThemeData(
                                          activeTrackColor: Colors.white,
                                          inactiveTrackColor: Colors.grey,
                                          thumbColor: Colors.transparent,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 0.0),
                                          trackHeight: 1,
                                        ),
                                        child: SizedBox(
                                          width: 470,
                                          child: Slider(
                                            max: totalDuration.inMilliseconds
                                                .toDouble(),
                                            value: value,
                                            onChanged: (double value) {},
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return SliderTheme(
                                    data: const SliderThemeData(
                                      activeTrackColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                      thumbColor: Colors.transparent,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 0.0),
                                      trackHeight: 1,
                                    ),
                                    child: SizedBox(
                                      width: 550,
                                      child: Slider(
                                        // max: totalDuration.inMilliseconds.toDouble(),
                                        value: 0,
                                        onChanged: (double value) {},
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: BottomNavigationBar(
                    elevation: 3,
                    currentIndex: _selectedIndex,
                    onTap: (index) => setState(() {
                      _selectedIndex = index;
                    }),
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.podcasts,
                        ),
                        label: "Your Podcasts",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.mic,
                        ),
                        label: "Recording",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.music_note,
                        ),
                        label: "Local Songs",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
