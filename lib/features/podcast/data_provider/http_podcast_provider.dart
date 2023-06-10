import 'dart:convert';
import 'dart:io';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/podcast/repository/podcast_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:http/http.dart' as httpLibrary;
import 'package:xml/xml.dart';

class HttpPodcastProvider implements PodcastRepository {
  final httpLibrary.Client httpClientLibrary;

  const HttpPodcastProvider({
    required this.httpClientLibrary,
  });

  @override
  Future<List<PodcastSearchResult>> search(String query) async {
    try {
      final response = await httpClientLibrary
          .get(Uri.parse('${Constants.iTunesSearchUrl}&term=$query'));
      List<dynamic> responseList = json.decode(response.body)["results"];

      return List<PodcastSearchResult>.from(
          responseList.map((item) => PodcastSearchResult.fromItunes(item)));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PodcastSearchResult>> getItunesTopList() async {
    try {
      final response =
          await httpClientLibrary.get(Uri.parse(Constants.iTunesTopList));
      final parsed =
          jsonDecode(response.body).cast<String, dynamic>()["feed"]["entry"];
      return parsed.map<PodcastSearchResult>((item) {
        // print(item);
        return PodcastSearchResult.fromItunesTopList(item);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Feed> getPodcastById(int id) async {
    try {
      final response = await httpClientLibrary.get(
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Accept": '*/*'
        },
        // Uri.https('itunes.apple.com', '/lookup', {'id': id}),
        Uri.parse("${Constants.iTunesLookupUrl}id=$id"),
      );
      final parsed =
          json.decode(response.body).cast<String, dynamic>()["results"][0];
      return getPodcast(parsed["feedUrl"]);
    } on RangeError {
      throw RangeError;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Feed> getPodcast(String url) async {
    try {
      // final request = await HttpClient().getUrl(Uri.parse(url));
      // final response = await request.close();
      // response.transform(utf8.decoder);
      final response = await httpClientLibrary.get(Uri.parse(url));
      // final content = await response.join();
      // print(content);
      final document = XmlDocument.parse(response.body);
      // print(document.rootElement);
      return Feed.fromXML(document.rootElement, url);
    } catch (e) {
      throw Exception(e);
    }
  }
}
