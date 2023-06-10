class PodcastSearchResult {
  final int id;
  final String title;
  final String imageUrl;
  final String feedUrl;
  final String author;

  const PodcastSearchResult({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.feedUrl,
    required this.author,
  });

  factory PodcastSearchResult.fromItunes(Map<String, dynamic> jsonResult) {
    return PodcastSearchResult(
      id: jsonResult["collectionId"],
      title: jsonResult["collectionName"],
      imageUrl: jsonResult["artworkUrl100"],
      feedUrl: jsonResult["feedUrl"],
      author: jsonResult["artistName"],
    );
  }

  factory PodcastSearchResult.fromItunesTopList(
      Map<String, dynamic> jsonResult) {
    return PodcastSearchResult(
      id: int.parse(jsonResult["id"]["attributes"]["im:id"]),
      title: jsonResult["im:name"]["label"],
      imageUrl: jsonResult["im:image"][2]["label"],
      feedUrl: jsonResult["link"]["attributes"]["href"],
      author: jsonResult["im:artist"]["label"],
    );
  }
}
