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
