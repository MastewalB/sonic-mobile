import 'package:sonic_mobile/models/audio.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:xml/xml.dart';

class FeedItem implements Audio {
  // final String guid;
  @override
  final String title;
  final String description;
  // final String pubDate;
  final String author;
  final String link;
  final String duration;
  @override
  final String? imageUrl;

  // final String size;

  @override
  String get artistName => author;

  @override
  String get fileUrl => link;

  const FeedItem({
    // required this.guid,
    required this.title,
    required this.description,
    // required this.pubDate,
    required this.author,
    required this.link,
    required this.duration,
    this.imageUrl,
    // required this.size,
  });

  factory FeedItem.fromXML(XmlElement episodeElement, String imageLink, String podcastAuthor) {
    // print('here');

    String durationString =
        episodeElement.findElements("itunes:duration").first.text;
    final enclosure = episodeElement.findElements('enclosure').first;
    // print(enclosure.getAttribute("url"));
    // final imageElement = episodeElement.findElements('image').first;
    // final imageLink = imageElement.findElements('url').first.text;
    return FeedItem(
        // guid: episodeElement.findElements("guid").first.text,
        title: episodeElement.findElements("title").first.text,
        description: episodeElement.findElements("description").first.text,
        // pubDate: episodeElement.findElements("pubDate").first.text,
        author: podcastAuthor,
        link: enclosure.getAttribute('url')!,
        duration: (durationString.startsWith("0"))
            ? durationString
            : UtilFunctions.getFormattedTime(
                Duration(
                  seconds: int.parse(durationString),
                ),
              ),
        imageUrl: imageLink
        // size: episodeElement.findElements("item").first.text,
        );
  }
}
