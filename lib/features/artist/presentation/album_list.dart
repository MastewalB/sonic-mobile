// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/presentation/album_page.dart';
import 'package:sonic_mobile/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:sonic_mobile/features/library/presentation/widgets/list_playlists.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

class AlbumListWidget extends StatelessWidget {
  final List<AlbumInfo> albums;
  final String artistUrl;
  final String name;
  final int numberOfAlbums;

  // final DateTime releaseDate;

  const AlbumListWidget({
    Key? key,
    required this.albums,
    required this.artistUrl,
    required this.name,
    required this.numberOfAlbums,
    // required this.releaseDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (albums.isEmpty) {
      return const Center(
          child: Text(
        'No items here',
        style: TextStyle(color: Colors.white),
      ));
    }
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 31, 29, 43),
            body: CustomScrollView(slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(14.0, 12.0, 0, 0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    height: 300,
                    // width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(artistUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 0.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumPage(albumID: albums[index].id),
                          ),
                        );
                      },
                      onDoubleTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: CardSmall(
                            title: albums[index].name,
                            duration: '',
                            // image: 'assets/music_icon_image.jpg',
                          )),
                        ],
                      ),
                    ),
                  );
                }, childCount: albums.length),
              )
            ])));
  }
}
