part of 'podcast_detail_bloc.dart';

abstract class PodcastDetailEvent extends Equatable {
  const PodcastDetailEvent();
}

class GetPodcastDetailEvent extends PodcastDetailEvent {
  @override
  List<Object?> get props => [];
}

class UpdatePodcastEvent extends PodcastDetailEvent {
  final String id;
  final String title;
  final String description;
  final String genre;

  const UpdatePodcastEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.genre,
  });

  @override
  List<Object?> get props => [];
}

class DeletePodcastEvent extends PodcastDetailEvent {
  final String id;

  const DeletePodcastEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [];
}

class CreateEpisodeInitial extends PodcastDetailEvent{
  @override
  List<Object?> get props => [];
}

class CreateEpisodeEvent extends PodcastDetailEvent {
  final String title;
  final String description;
  final String podcastId;
  final File file;

  const CreateEpisodeEvent({
    required this.title,
    required this.description,
    required this.podcastId,
    required this.file,
  });

  @override
  List<Object?> get props => [];
}

class ListEpisodeRecordingsEvent extends PodcastDetailEvent {
  @override
  List<Object?> get props => [];
}
