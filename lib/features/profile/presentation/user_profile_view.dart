import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/library/bloc/library_bloc/library_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/playlist_detail_page.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/screen_arguments.dart';
import 'package:sonic_mobile/features/profile/bloc/user_profile/user_profile_bloc.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/profile/presentation/widgets/profile_info.dart';
import 'package:sonic_mobile/features/profile/repository/profile_data_provider.dart';
import 'responsive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class UserProfileView extends StatelessWidget {
  // static const String routeName = "user_profile";
  final String userId;
  const UserProfileView({required this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double safeAreaWidth = MediaQueryManager.safeAreaHorizontal;
    double circleAvatarWidth = safeAreaWidth * 8;

    return Scaffold(
        body: SafeArea(
      child: BlocProvider<UserProfileBloc>(
        create: (context) =>
            // context.read<UserProfileBloc>().add(LoadUserProfile(userId)),
            UserProfileBloc(ProfileDataProvider(httpClient: http.Client())),
        child: Builder(builder: (context) {
          final userPorfileBloc = context.read<UserProfileBloc>();
          userPorfileBloc.add(LoadUserProfile(userId));
          return Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(Constants.defaultPadding),
                decoration: BoxDecoration(
                  color: Constants.secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                    if (state is UserProfileLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 40, 0),
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFffffff),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.blueGrey,
                                                blurRadius:
                                                    1.0, // soften the shadow
                                                spreadRadius:
                                                    5.0, //extend the shadow
                                              )
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/avatar.png'),
                                            radius: 50,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${state.profile.firstName} ${state.profile.lastName}',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.add_box_rounded,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    } else if (state is UserProfileError) {
                      return const Center(
                        child: Text('Error'),
                      );
                    } else if (state is UserProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 28, 0, 10),
                child: Center(
                    child: Text(
                  "Playlists",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: BorderSide.strokeAlignCenter),
                )),
              ),
              // const SizedBox(height: 22.0,),
              // Expanded(
              //   child: BlocBuilder<LibraryBloc, LibraryState>(
              //     builder: (context, state) {
              //       return ListView.builder(
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 8),
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.pushNamed(
              //                   context,
              //                   PlaylistDetailPage.routeName,
              //                   arguments: PlaylistDetailArgument(
              //                     state.playlists[index],
              //                   ),
              //                 );
              //               },
              //               child: ListTile(
              //                 title: Text(
              //                   state.playlists[index].playlistTitle,
              //                   style: const TextStyle(
              //                     fontSize: 19,
              //                     fontWeight: FontWeight.w500,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 leading: CircleAvatar(
              //                   radius: circleAvatarWidth,
              //                   backgroundImage: const AssetImage(
              //                     "assets/images/podcast_icon.jpg",
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //         itemCount: state.playlists.length,
              //       );
              //     },
              //   ),
              // ),

              //Place to add the bottom dashboard
            ],
          );
        }),
      ),
    ));
  }
}
