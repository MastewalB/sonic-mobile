class Podcast {
  final String id;
  final String podcastUrl;

  Podcast({required this.id, required this.podcastUrl});
}

class Episode {
  final String episodeUrl;
  final String podcastUrl;

  Episode({required this.episodeUrl, required this.podcastUrl});
}

class PodcastSubscription {
  final String user;
  final Podcast podcast;

  PodcastSubscription({required this.user, required this.podcast});
}
