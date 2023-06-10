part of 'podcast_bloc.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();
}

class PodcastInitial extends PodcastState {
  @override
  List<Object> get props => [];
}

class PodcastLoading extends PodcastState {
  @override
  List<Object> get props => [];
}

class PodcastReady extends PodcastState {
  final Feed feed;

  @override
  List<Object> get props => [];

  const PodcastReady({
    required this.feed,
  });
}

class PodcastError extends PodcastState {
  @override
  List<Object> get props => [];
}
