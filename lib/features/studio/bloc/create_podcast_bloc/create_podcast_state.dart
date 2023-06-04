part of 'create_podcast_bloc.dart';

enum CreatePodcastStatus {
  initial,
  createPodcastLoading,
  podcastCreated,
  error
}

extension CreatePodcastStatusX on CreatePodcastStatus {
  bool get isInitial => this == CreatePodcastStatus.initial;

  bool get isCreatingPodcast =>
      this == CreatePodcastStatus.createPodcastLoading;

  bool get isPodcastCreated => this == CreatePodcastStatus.podcastCreated;

  bool get isError => this == CreatePodcastStatus.error;
}

class CreatePodcastState extends Equatable {
  final CreatePodcastStatus status;
  final StudioPodcast? podcast;
  final ErrorType errorType;

  const CreatePodcastState({
    this.status = CreatePodcastStatus.initial,
    this.errorType = ErrorType.NONE,
    this.podcast,
  });

  @override
  List<Object?> get props => [status, podcast, errorType];

  CreatePodcastState copyWith(
      {CreatePodcastStatus? status, StudioPodcast? podcast, ErrorType? errorType}) {
    return CreatePodcastState(
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      podcast: podcast ?? this.podcast,
    );
  }
}
