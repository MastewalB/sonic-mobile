import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/audio_player/presentation/player_page.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    final TextStyle miniPlayerTitleStyle =
        TextStyle(color: Colors.white, fontSize: 18);

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
          )
        ],
      ),
      bottomNavigationBar: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: state.isPlaying,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: (state.status.isLoading ||
                                          state.status.isInitial ||
                                          state.status.isFailure)
                                      ? const DecorationImage(
                                          image: AssetImage(
                                            'assets/music_icon_image.jpg',
                                          ),
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(
                                              "https://images.ecestaticos.com/xnNbBZp8-d8EtrRzQNEnUp3hOL4=/0x60:1919x1138/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Fcc3%2F6d5%2F5eb%2Fcc36d55ebd0a8c375b6530ab68b0252b.jpg"),
                                        ),
                                ),
                                constraints: const BoxConstraints(
                                  maxHeight: 60,
                                  maxWidth: 60,
                                ),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 10, vertical: 10),
                                // child: Image(
                                //   image: FileImage(File(state.audioQueue!
                                //       .elementAt(state.currentIndex)
                                //       .thumbnail)),
                                // )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxHeight: 60, maxWidth: 150),
                                child: (state.audioQueue!.isNotEmpty)
                                    ? (state.audioQueue!
                                                .elementAt(state.currentIndex)
                                                .title
                                                .length >
                                            15)
                                        ? Marquee(
                                            text: state.audioQueue!
                                                .elementAt(state.currentIndex)
                                                .title,
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
                                            state.audioQueue!
                                                .elementAt(state.currentIndex)
                                                .title,
                                            style: miniPlayerTitleStyle,
                                          )
                                    : Text(""),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, PlayerPage.routeName);
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                              audioPlayerBloc.add(PlayPreviousEvent());
                            },
                            child: Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.white,
                              size: 40,
                            )),
                        GestureDetector(
                          child: (state.status.isLoading)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Icon(
                                  (state.status.isPlaying)
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                          onTap: () {
                            (state.audioPlayer.state.name == "PLAYING")
                                ? audioPlayerBloc.add(PauseAudioEvent())
                                : audioPlayerBloc.add(ResumeAudioEvent());
                          },
                        ),
                        GestureDetector(
                            onTap: () {
                              audioPlayerBloc.add(PlayNextEvent());
                            },
                            child: Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                              size: 40,
                            )),
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
                  ),
                ),
              ),
              BottomNavigationBar(
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
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
