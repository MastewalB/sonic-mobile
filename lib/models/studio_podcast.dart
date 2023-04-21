import 'package:sonic_mobile/models/models.dart';

class StudioPodcast {
  final String id;
  final String title;
  final User author;
  final String description;
  final String genre;
  final int numberOfEpisodes;
  final List<StudioEpisode> episodes;

  const StudioPodcast({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.numberOfEpisodes,
    required this.episodes,
  });

  factory StudioPodcast.fromJson(Map<String, dynamic> json) {
    return StudioPodcast(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      description: json["description"],
      genre: json["genres"],
      episodes: json["episodes"],
      numberOfEpisodes: json["number_of_episodes"],
    );
  }


}
