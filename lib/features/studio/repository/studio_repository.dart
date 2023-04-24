import 'package:sonic_mobile/models/models.dart';

abstract class StudioRepository {
  Future<void> createPodcast(String title, String description, String genre);

  Future<List<StudioPodcast>> getPodcastsByUser(String userId);

  Future<StudioPodcast> getPodcastDetail(String podcastId);

  Future<void> deletePodcast(String podcastId);

  Future<StudioPodcast> updatePodcast(
      String? title, String? description, String? genre);
}
