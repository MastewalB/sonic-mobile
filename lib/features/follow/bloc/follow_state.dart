part of 'follow_bloc.dart';

abstract class FollowState extends Equatable {
  const FollowState();
}

class FollowInitial extends FollowState {
  @override
  List<Object> get props => [];
}

class FollowLoading extends FollowState {
  @override
  List<Object> get props => [];
}

class FollowersListLoaded extends FollowState{
  final List<String> users;

  const FollowersListLoaded({
    required this.users,
  });

  @override
  List<Object> get props => [];
}

class StreamersLoaded extends FollowState {
  final List<PublicUser> users;

  @override
  List<Object> get props => [];

  const StreamersLoaded({
    required this.users,
  });
}

class FollowError extends FollowState {
  @override
  List<Object> get props => [];
}