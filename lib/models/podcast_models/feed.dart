import 'package:sonic_mobile/models/audio.dart';
import 'package:sonic_mobile/models/audio_list.dart';
import 'package:xml/xml.dart';
import 'feed_item.dart';

class Feed implements AudioList{
  // final int id;
  final String podcastTitle;
  final String author;
  // final String pubDate;
  final String feedUrl;
  final String description;
  final String language;
  final String imageUrl;
  final List<FeedItem> episodes;

  @override
  String get audioListTitle => podcastTitle;

  @override
  List<Audio> get audioListItems => episodes;

  const Feed({
    // required this.id,
    required this.podcastTitle,
    required this.author,
    // required this.pubDate,
    required this.feedUrl,
    required this.description,
    required this.language,
    required this.imageUrl,
    required this.episodes,
  });

  factory Feed.fromXML(XmlElement xmlElement, String url) {
    final podcastElement = xmlElement.findElements('channel').first;
    final imageElement = podcastElement.findElements('image').first;
    final imageUrl = imageElement.findElements('url').first.text;
    final podcastAuthor = podcastElement.findElements("itunes:author").first.text;
    // final ff = podcastElement.findElements("pubDate").first.text;
    // print(ff);
    return Feed(
        podcastTitle: podcastElement.findElements("title").first.text,
        author: podcastAuthor,
        // pubDate: podcastElement.findElements("pubDate").first.text,
        feedUrl: url,
        description: podcastElement.findElements("description").first.text,
        language: podcastElement.findElements("language").first.text,
        imageUrl: imageUrl,
        episodes: podcastElement
            .findAllElements("item")
            .map((e) => FeedItem.fromXML(e, imageUrl, podcastAuthor))
            .toList());
  }
}
