part of 'podcast_bloc.dart';

abstract class PodcastEvent extends Equatable {
  const PodcastEvent();
}

class GetItunesTopList extends PodcastEvent {
  @override
  List<Object?> get props => [];
}

class SearchPodcastItunesEvent extends PodcastEvent {
  final String query;

  @override
  List<Object?> get props => [];

  const SearchPodcastItunesEvent({
    required this.query,
  });
}

class GetPodcastById extends PodcastEvent {
  final int podcastId;

  @override
  List<Object?> get props => [];

  const GetPodcastById({
    required this.podcastId,
  });
}
