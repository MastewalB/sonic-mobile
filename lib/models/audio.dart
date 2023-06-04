import 'package:on_audio_query/on_audio_query.dart';

class Audio {
  final String title;
  final String artistName;
  final String fileUrl;

  Audio(
    this.title,
    this.artistName,
    this.fileUrl,
  );

  factory Audio.fromSongModel(SongModel songModel) {
    return Audio(
      songModel.title,
      songModel.artist ?? "Unknown",
      songModel.data,
    );
  }
}
