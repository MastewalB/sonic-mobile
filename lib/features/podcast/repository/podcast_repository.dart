import 'package:sonic_mobile/models/models.dart';

abstract class PodcastRepository {
  Future<List<PodcastSearchResult>> search(String query);
  Future<List<PodcastSearchResult>> getItunesTopList();
  Future<Feed> getPodcastById(int id);
  Future<Feed> getPodcast(String url);
}
