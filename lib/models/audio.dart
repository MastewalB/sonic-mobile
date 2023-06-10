import 'package:on_audio_query/on_audio_query.dart';

class Audio {
  final String title;
  final String artistName;
  final String fileUrl;
  final String? imageUrl;

  Audio({
    required this.title,
    required this.artistName,
    required this.fileUrl,
    this.imageUrl,
  });

  factory Audio.fromSongModel(SongModel songModel) {
    return Audio(
      title: songModel.title,
      artistName: songModel.artist ?? "Unknown",
      fileUrl: songModel.data,
    );
  }
}
