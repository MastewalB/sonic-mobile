import 'package:sonic_mobile/models/models.dart';

class StudioEpisode implements Audio {
  final String id;
  @override
  final String title;
  final int index;
  final StudioPodcastInfo podcast;
  final String description;
  final DateTime uploadDate;
  final String file;

  @override
  String get artistName => podcast.author.fullName;

  @override
  String get fileUrl => file;

  const StudioEpisode({
    required this.id,
    required this.title,
    required this.index,
    required this.podcast,
    required this.description,
    required this.uploadDate,
    required this.file,
  });

  factory StudioEpisode.fromJson(Map<String, dynamic> json) {
    return StudioEpisode(
      id: json["id"],
      title: json["title"],
      index: json["index"],
      podcast: StudioPodcastInfo.fromJson(json['podcast']),
      description: json["description"],
      uploadDate: DateTime.parse(json["upload_date"]),
      file: json["file"],
    );
  }

  Map<String, dynamic> toJson(StudioEpisode episode) {
    return {
      "title": episode.title,
      'description': episode.description,
      "podcast": episode.podcast,
      "upload_date": episode.uploadDate,
      "file": episode.file,
    };
  }
}
