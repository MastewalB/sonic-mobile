import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/player_page.dart';
import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/library/presentation/your_playlist_page.dart';
import 'package:sonic_mobile/routes.dart';
import 'package:sonic_mobile/features/audio_player/presentation/widgets/time_slider.dart';

class LibraryPage extends StatefulWidget {
  static const String routeName = "library";

  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _selectedIndex = 0;
  final PageRouter pageRouter = PageRouter();

  final _yourPlaylistPageKey = GlobalKey<NavigatorState>();

  Future<bool> _onPlaylistWillPop() async {
    if (_yourPlaylistPageKey.currentState != null) {
      _yourPlaylistPageKey.currentState!.maybePop();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    const TextStyle miniPlayerTitleStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
    );

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WillPopScope(
            onWillPop: _onPlaylistWillPop,
            child: Navigator(
              key: _yourPlaylistPageKey,
              onGenerateRoute: pageRouter.generateRoute,
              initialRoute: YourPlaylists.routeName,
            ),
          ),
          Container(),
          Container(),
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
                                          width: 460,
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
                          Icons.home_filled,
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.search,
                        ),
                        label: "Search",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.bar_chart,
                        ),
                        label: "Library",
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
