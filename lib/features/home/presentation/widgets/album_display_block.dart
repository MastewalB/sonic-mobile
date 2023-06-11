import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/album/presentation/album_page.dart';
import 'package:sonic_mobile/features/home/bloc/album/album_bloc.dart';
import '../../bloc/song/blocs.dart';

class AlbumDisplayBlock extends StatelessWidget {
  final String desc;

  const AlbumDisplayBlock({Key? key, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(
            desc,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {
              if (state is AlbumErrorState) {
                return const Center(
                  child: Text(
                    "A Network Error Occurred",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }
              if (state is AlbumLoadedState) {
                final albums = state.albums; // Access the songs from the state

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      albums.length, // Use the count of songs from the state
                  itemBuilder: (BuildContext context, int index) {
                    final album =
                        albums[index]; // Access the song based on the index

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AlbumPage(albumID: album.id),
                                ),
                              );
                            },
                            child: Container(
                              height: 120.0,
                              width: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(album.cover),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            album.name, // Use the title from the song object
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            album.artist
                                .name, // Use the artist from the song object
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              // Show a placeholder or loading state when songs are not yet loaded
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
