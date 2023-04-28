part of 'create_podcast_bloc.dart';

abstract class CreatePodcastEvent extends Equatable {
  const CreatePodcastEvent();
}

class CreateNewPodcastEvent extends CreatePodcastEvent {
  final String title;
  final String description;
  final String genre;

  const CreateNewPodcastEvent({
    required this.title,
    required this.description,
    required this.genre,
  });

  @override
  List<Object?> get props => [];


}