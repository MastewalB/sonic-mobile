import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/follow/repository/follow_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';

part 'follow_event.dart';

part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowRepository followRepository;
  final UserProfileRepository userProfileRepository;

  FollowBloc({
    required this.followRepository,
    required this.userProfileRepository,
  }) : super(FollowInitial()) {
    on<FollowEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetStreamingFriends>((event, emit) async {
      emit(FollowLoading());
      try {
        await userProfileRepository.getUser().then((value) async {
          await followRepository
              .getAllStreamingFriends(value.id)
              .then((friendsList) {
            emit(StreamersLoaded(users: friendsList));
          });
        });
      } on AppException catch (e) {
        print(e.toString());
        emit(FollowError());
      }
    });

    on<GetFollowersEvent>((event, emit) async {
      try {
        await userProfileRepository.getUser().then((value) async {
          await followRepository
              .getFollowerList(value.id)
              .then((followerList) async {
            emit(FollowersListLoaded(
              users: followerList,
            ));
          });
        });
      } on AppException catch (e) {
        // print(e.toString());
        emit(FollowError());
      }
    });

    on<FollowUserEvent>((event, emit) async {
      emit(FollowLoading());
      try {
        await followRepository.followUser(event.userId);
        add(GetFollowersEvent());
      } on AppException catch (e) {
        emit(FollowError());
      }
    });

    on<UnfollowUserEvent>((event, emit) async {
      emit(FollowLoading());
      try {
        await followRepository.unFollowUser(event.userId);
        add(GetFollowersEvent());
      } on AppException catch (e) {
        // print(e.toString());
        emit(FollowError());
      }
    });
  }
}
