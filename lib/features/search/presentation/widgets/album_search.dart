import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/album/presentation/widgets/audio_list.dart';
import 'empty_screen.dart';
import 'bouncy_scroll_view.dart';

class AlbumSearchPage extends StatefulWidget {
  final String query;
  final String type;

  const AlbumSearchPage({
    super.key,
    required this.query,
    required this.type,
  });

  @override
  _AlbumSearchPageState createState() => _AlbumSearchPageState();
}

class _AlbumSearchPageState extends State<AlbumSearchPage> {
  int page = 1;
  bool loading = false;
  List<Map>? _searchedList;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        page += 1;
        // _fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: _searchedList == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _searchedList!.isEmpty
                    ? emptyScreen(
                        context,
                        0,
                        ':( ',
                        100,
                        'Sorry',
                        60,
                        'Results Not Found',
                        20,
                      )
                    : BouncyImageSliverScrollView(
                        scrollController: _scrollController,
                        title: widget.type,
                        placeholderImage: widget.type == 'Artists'
                            ? 'assets/artist.png'
                            : 'assets/album.png',
                        sliverList: SliverList(
                          delegate: SliverChildListDelegate(
                            _searchedList!.map(
                              (Map entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 7),
                                  child: ListTile(
                                    title: Text(
                                      '${entry["title"]}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onLongPress: () {},
                                    subtitle: entry['subtitle'] == ''
                                        ? null
                                        : Text(
                                            '${entry["subtitle"]}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    leading: Card(
                                      margin: EdgeInsets.zero,
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          widget.type == 'Artists' ? 50.0 : 7.0,
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      // child: CachedNetworkImage(
                                      //   fit: BoxFit.cover,
                                      //   errorWidget: (context, _, __) =>
                                      //       Image(
                                      //     fit: BoxFit.cover,
                                      //     image: AssetImage(
                                      //       widget.type == 'Artists'
                                      //           ? 'assets/artist.png'
                                      //           : 'assets/album.png',
                                      //     ),
                                      //   ),
                                      //   imageUrl:
                                      //       '${entry["image"].replaceAll('http:', 'https:')}',
                                      //   placeholder: (context, url) => Image(
                                      //     fit: BoxFit.cover,
                                      //     image: AssetImage(
                                      //       widget.type == 'Artists'
                                      //           ? 'assets/artist.png'
                                      //           : 'assets/album.png',
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                    trailing:
                                        widget.type != 'Albums' ? null : null,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              widget.type == 'Artists'
                                                  // ? ArtistSearchPage(
                                                  //     data: entry,
                                                  //   )
                                                  ? SizedBox()
                                                  : const AudioListWidget(
                                                      songs: [],
                                                    ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
          ),
        ),
        // MiniPlayer(),
      ],
    );
  }
}
