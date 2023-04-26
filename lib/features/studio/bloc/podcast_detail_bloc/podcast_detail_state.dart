part of 'podcast_detail_bloc.dart';

enum PodcastDetailStatus {
  initial,
  loading,
  loaded,
  podcastDeleted,
  error,
}

extension PodcastDetailStatusX on PodcastDetailStatus {
  bool get isInitial => this == PodcastDetailStatus.initial;
  bool get isLoading => this == PodcastDetailStatus.loading;
  bool get isLoaded => this == PodcastDetailStatus.loaded;
  bool get isPodcastDeleted => this == PodcastDetailStatus.podcastDeleted;
  bool get isError => this == PodcastDetailStatus.error;

}

class PodcastDetailState extends Equatable {
  final PodcastDetailStatus status;
  final StudioPodcast? podcast;
  final ErrorType errorType;

  const PodcastDetailState({
    this.status = PodcastDetailStatus.initial,
    this.errorType = ErrorType.NONE,
    this.podcast,
  });

  @override
  List<Object?> get props => [status, podcast, errorType];

  PodcastDetailState copyWith({
    PodcastDetailStatus? status,
    StudioPodcast? podcast,
    ErrorType? errorType,
  }) {
    return PodcastDetailState(
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      podcast: podcast ?? this.podcast,
    );
  }
}
