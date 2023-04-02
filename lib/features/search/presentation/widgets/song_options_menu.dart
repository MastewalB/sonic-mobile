// import 'package:audio_service/audio_service.dart';
// import 'package:blackhole/CustomWidgets/add_playlist.dart';
// import 'package:blackhole/Helpers/add_mediaitem_to_queue.dart';
// import 'package:blackhole/Helpers/mediaitem_converter.dart';
// import 'package:blackhole/Screens/Common/song_list.dart';
// import 'package:blackhole/Screens/Search/albums.dart';
// import 'package:blackhole/Screens/Search/search.dart';
// import 'package:blackhole/Services/youtube_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';

class SongTileTrailingMenu extends StatefulWidget {
  final Map data;
  final bool isPlaylist;
  final Function(Map)? deleteLiked;
  const SongTileTrailingMenu({
    super.key,
    required this.data,
    this.isPlaylist = false,
    this.deleteLiked,
  });

  @override
  _SongTileTrailingMenuState createState() => _SongTileTrailingMenuState();
}

class _SongTileTrailingMenuState extends State<SongTileTrailingMenu> {
  @override
  Widget build(BuildContext context) {
    // final MediaItem mediaItem = MediaItemConverter.mapToMediaItem(widget.data);
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        if (widget.isPlaylist && widget.deleteLiked != null)
          PopupMenuItem(
            value: 6,
            child: Row(
              children: const [
                Icon(
                  Icons.delete_rounded,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('Remove'),
              ],
            ),
          ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.playlist_play_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 26.0,
              ),
              const SizedBox(width: 10.0),
              const Text('Play Next'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.queue_music_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('Add to queue'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.playlist_add_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('Add to Playlist'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(
                Icons.album_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('View Album'),
            ],
          ),
        ),
        // if (mediaItem.artist != null)
        //   ...mediaItem.artist.toString().split(', ').map(
        //         (artist) => PopupMenuItem(
        //           value: artist,
        //           child: SingleChildScrollView(
        //             scrollDirection: Axis.horizontal,
        //             child: Row(
        //               children: [
        //                 Icon(
        //                   Icons.person_rounded,
        //                   color: Theme.of(context).iconTheme.color,
        //                 ),
        //                 const SizedBox(width: 10.0),
        //                 const Text(
        //                   'View Artist',
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.share_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10.0),
              const Text('Share'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        // switch (value) {
        //   case 3:
        //     Share.share(widget.data['perma_url'].toString());
        //     break;

        //   case 4:
        //     Navigator.push(
        //       context,
        //       PageRouteBuilder(
        //         opaque: false,
        //         pageBuilder: (_, __, ___) => SongsListPage(
        //           listItem: {
        //             'type': 'album',
        //             'id': mediaItem.extras?['album_id'],
        //             'title': mediaItem.album,
        //             'image': mediaItem.artUri,
        //           },
        //         ),
        //       ),
        //     );
        //     break;
        //   case 6:
        //     widget.deleteLiked!(widget.data);
        //     break;
        //   case 0:
        //     AddToPlaylist().addToPlaylist(context, mediaItem);
        //     break;
        //   case 1:
        //     addToNowPlaying(context: context, mediaItem: mediaItem);
        //     break;
        //   case 2:
        //     playNext(mediaItem, context);
        //     break;
        //   default:
        //     Navigator.push(
        //       context,
        //       PageRouteBuilder(
        //         opaque: false,
        //         pageBuilder: (_, __, ___) => AlbumSearchPage(
        //           query: value.toString(),
        //           type: 'Artists',
        //         ),
        //       ),
        //     );
        //     break;
        // }
      },
    );
  }
}
