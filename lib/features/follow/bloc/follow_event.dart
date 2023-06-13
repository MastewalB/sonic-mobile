part of 'follow_bloc.dart';

abstract class FollowEvent extends Equatable {
  const FollowEvent();
}

class FollowInitialEvent extends FollowEvent {
  @override
  List<Object?> get props => [];
}

class GetStreamingFriends extends FollowEvent {
  @override
  List<Object?> get props => [];
}

class GetFollowersEvent extends FollowEvent {
  @override
  List<Object?> get props => [];
}

class FollowUserEvent extends FollowEvent {
  final String userId;

  @override
  List<Object?> get props => [];

  const FollowUserEvent({
    required this.userId,
  });
}

class UnfollowUserEvent extends FollowEvent {
  final String userId;

  @override
  List<Object?> get props => [];

  const UnfollowUserEvent({
    required this.userId,
  });
}