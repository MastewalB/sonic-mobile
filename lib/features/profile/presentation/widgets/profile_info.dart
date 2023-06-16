// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'package:sonic_mobile/features/profile/bloc/view_profile/profile_bloc.dart';
import 'package:sonic_mobile/features/profile/presentation/edit_profile_page.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        color: Constants.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Homepage.routeName);
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
                                      blurRadius: 1.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                    )
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                  radius: 50,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 211, 205, 205),
                            ),
                          ),

                          Text(
                            '${state.profile.firstName} ${state.profile.lastName}',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                overflow: TextOverflow.visible),
                            softWrap: true,
                          ),

                          // RichText(
                          //   selectionColor: Colors.white,
                          //   text: TextSpan(
                          //     text: ".8",
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w100,
                          //       color: Colors.white,
                          //     ),
                          //     children: [
                          //       TextSpan(
                          //         text: ' Followers   ',
                          //         style: TextStyle(
                          //           // fontFamily: 'courier',
                          //           fontSize: 14,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text: '.13',
                          //         style: TextStyle(
                          //           // fontFamily: 'courier',
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w800,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //       TextSpan(
                          //         text: ' Following',
                          //         style: TextStyle(
                          //           // fontFamily: 'courier',
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w100,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, EditProfilePage.routeName);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else if (state is ProfileError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
