part of 'podcast_detail_bloc.dart';

enum PodcastDetailStatus {
  initial,
  loading,
  loaded,
  podcastDeleted,
  episodeCreated,
  recordingsLoaded,
  error,
}

extension PodcastDetailStatusX on PodcastDetailStatus {
  bool get isInitial => this == PodcastDetailStatus.initial;

  bool get isLoading => this == PodcastDetailStatus.loading;

  bool get isLoaded => this == PodcastDetailStatus.loaded;

  bool get isPodcastDeleted => this == PodcastDetailStatus.podcastDeleted;

  bool get isEpisodeCreated => this == PodcastDetailStatus.episodeCreated;

  bool get isRecordingsLoaded => this == PodcastDetailStatus.recordingsLoaded;

  bool get isError => this == PodcastDetailStatus.error;
}

class PodcastDetailState extends Equatable {
  final PodcastDetailStatus status;
  final StudioPodcast? podcast;
  final List<Recording>? recordings;
  final ErrorType errorType;

  const PodcastDetailState({
    this.status = PodcastDetailStatus.initial,
    this.errorType = ErrorType.NONE,
    this.podcast,
    this.recordings,
  });

  @override
  List<Object?> get props => [status, podcast, errorType, recordings];

  PodcastDetailState copyWith({
    PodcastDetailStatus? status,
    StudioPodcast? podcast,
    List<Recording>? recordings,
    ErrorType? errorType,
  }) {
    return PodcastDetailState(
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      recordings: recordings ?? this.recordings,
      podcast: podcast ?? this.podcast,
    );
  }
}
