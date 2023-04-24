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

  const CreatePodcastState({
    this.status = CreatePodcastStatus.initial,
    this.podcast,
  });

  @override
  List<Object?> get props => [status, podcast];

  CreatePodcastState copyWith(
      {CreatePodcastStatus? status, StudioPodcast? podcast}) {
    return CreatePodcastState(
      status: status ?? this.status,
      podcast: podcast ?? this.podcast,
    );
  }
}
