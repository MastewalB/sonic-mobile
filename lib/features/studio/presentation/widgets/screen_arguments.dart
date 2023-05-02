import 'package:on_audio_query/on_audio_query.dart';
import 'package:sonic_mobile/models/models.dart';

class PodcastScreenArgument {
  final StudioPodcast podcast;

  PodcastScreenArgument(this.podcast);
}

class StudioLibraryScreenArguments {
  final int? initialIndex;

  StudioLibraryScreenArguments(this.initialIndex);
}

class CreateEpisodeScreenArguments {
  final StudioPodcast podcast;

  CreateEpisodeScreenArguments(this.podcast);
}

class FolderSongsArguments {
  final List<SongModel> songs;
  final String folderName;

  const FolderSongsArguments({
    required this.songs,
    required this.folderName,
  });
}
