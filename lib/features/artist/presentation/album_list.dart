import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/album/presentation/album_page.dart';
import 'package:sonic_mobile/features/artist/presentation/widgets/album_grid.dart';
import 'package:sonic_mobile/models/models.dart';

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
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 0, 0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  // width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: AspectRatio(
                      aspectRatio: 0.5,
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
              padding: const EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 20.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0, 20.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Albums',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SliverGrid.builder(
              // shrinkWrap: true,
              itemCount: albums.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.9,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AlbumPage(albumID: albums[index].id),
                      ),
                    );
                  },
                  child: AlbumCard(album: albums[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
