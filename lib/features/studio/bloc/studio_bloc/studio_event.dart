part of 'studio_bloc.dart';

abstract class StudioEvent extends Equatable {
  const StudioEvent();
}

class StudioInitialEvent extends StudioEvent{
  @override
  List<Object?> get props => [];
}

class GetAllPodcastsByUserEvent extends StudioEvent {
  // final String userId;
  //
  // const GetAllPodcastsByUserEvent({
  //   required this.userId,
  // });

  @override
  List<Object?> get props => [];
}
