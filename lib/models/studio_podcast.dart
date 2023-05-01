import 'package:sonic_mobile/models/models.dart';

class StudioPodcast implements AudioList {
  final String id;
  final String title;
  final PublicUser author;
  final String description;
  final String genre;
  final int numberOfEpisodes;
  final List<StudioEpisode> episodes;

  @override
  String get audioListTitle => title;

  @override
  List<StudioEpisode> get audioListItems => episodes;

  StudioPodcast({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.numberOfEpisodes,
    required this.episodes,
  });

  factory StudioPodcast.fromJson(Map<String, dynamic> json) {
    List<StudioEpisode> episodes = [];
    for (var episode in json["episodes"]) {
      episodes.add(StudioEpisode.fromJson(episode));
    }
    return StudioPodcast(
      id: json["id"],
      title: json["title"],
      author: PublicUser.fromJson(json["author"]),
      description: json["description"],
      genre: json["genre"],
      episodes: episodes,
      numberOfEpisodes: json["number_of_episodes"],
    );
  }
}

class StudioPodcastInfo {
  final String id;
  final String title;
  final PublicUser author;
  final String description;
  final String genre;
  final int numberOfEpisodes;

  const StudioPodcastInfo({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genre,
    required this.numberOfEpisodes,
  });

  factory StudioPodcastInfo.fromJson(Map<String, dynamic> json) {
    return StudioPodcastInfo(
      id: json["id"],
      title: json["title"],
      author: PublicUser.fromJson(json["author"]),
      description: json["description"],
      genre: json["genre"],
      numberOfEpisodes: json["number_of_episodes"],
    );
  }
}
