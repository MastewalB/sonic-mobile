import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);
    return BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
        builder: (_, state) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/icons/queue-duotone-svgrepo-com.svg',
                    width: 25,
                    height: 25,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (!state.status.isInitial ||
                        !state.status.isFailure ||
                        !state.status.isFailure) {
                      showBottomSheet(
                          context: context,
                          enableDrag: true,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.05),
                          builder: (context) {
                            return SizedBox(
                              height: 300,
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 8.0,
                                    sigmaY: 8.0,
                                  ),
                                  child: ListView.builder(
                                      itemCount: state.audioQueue!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<AudioPlayerBloc>()
                                                  .add(PlayAudioEvent(
                                                    currentIndex: index,
                                                    fromCurrentPlaylist: true,
                                                  ));
                                            },
                                            child: ListTile(
                                              leading: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                errorWidget: (BuildContext
                                                            context,
                                                        _,
                                                        __) =>
                                                    SvgPicture.asset(
                                                        'assets/icons/music-circle.svg'),
                                                placeholder:
                                                    (BuildContext context, _) =>
                                                        Container(
                                                  // fit: BoxFit.cover,
                                                  color: Colors.black26,
                                                  child: SvgPicture.asset(
                                                      'assets/icons/music-circle.svg'),
                                                ),
                                                imageUrl: state.audioQueue!
                                                    .elementAt(index)
                                                    .thumbnail,
                                                height: 50,
                                                width: 50,
                                              ),
                                              title: Text(
                                                state.audioQueue!
                                                    .elementAt(index)
                                                    .description,
                                                style: TextStyle(
                                                  color: (state.currentIndex ==
                                                          index)
                                                      ? Colors.lightBlue
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              subtitle: Text(
                                                state.audioQueue!
                                                    .elementAt(index)
                                                    .category,
                                                style: TextStyle(
                                                  color: (state.currentIndex ==
                                                          index)
                                                      ? Colors.lightBlue
                                                      : Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              trailing: (state.currentIndex ==
                                                      index)
                                                  ? Icon(
                                                      Icons
                                                          .stacked_bar_chart_rounded,
                                                      color: Colors.lightBlue,
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/icons/previous-svgrepo-com.svg',
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () {
                    audioPlayerBloc.add(PlayPreviousEvent());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GestureDetector(
                    child: (state.status.isLoading)
                        ? Stack(
                            children: const [
                              SizedBox(
                                height: 65,
                                width: 65,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 64,
                                width: 64,
                                child: Center(
                                  child: Icon(
                                    Icons.pause_circle,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            (state.status.isPlaying)
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                    onTap: () {
                      (state.audioPlayer.state.name == "PLAYING")
                          ? audioPlayerBloc.add(PauseAudioEvent())
                          : audioPlayerBloc.add(ResumeAudioEvent());
                    },
                  ),
                ),
                GestureDetector(
                  child: SvgPicture.asset(
                    'assets/icons/next-svgrepo-com.svg',
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () {
                    audioPlayerBloc.add(PlayNextEvent());
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                GestureDetector(
                  child: (state.isLooping)
                      ? SvgPicture.asset(
                          'assets/icons/repeat-one-svgrepo-com.svg',
                          width: 35,
                          height: 35,
                          color: Colors.green,
                        )
                      : SvgPicture.asset(
                          'assets/icons/repeat-svgrepo-com.svg',
                          width: 35,
                          height: 35,
                          color: Colors.white,
                        ),
                  onTap: () {
                    audioPlayerBloc.add(ToggleLoopEvent());
                  },
                )
              ],
            ),
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Something went wrong."),
              duration: Duration(seconds: 2),
            ));
          }
        });
  }
}
