import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/core/core.dart';
import 'package:sonic_mobile/features/follow/repository/follow_repository.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/features/auth/repository/repository.dart';

part 'stream_event.dart';

part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  final FollowRepository followRepository;
  final UserProfileRepository userProfileRepository;

  StreamBloc({
    required this.followRepository,
    required this.userProfileRepository,
  }) : super(StreamInitial()) {
    on<StreamEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<StreamInitialEvent>((event, emit)async{
      try{
        await followRepository.isStreamOn().then((value) {
          if(value){
            emit(StreamOn());
          }else{
            emit(StreamOff());
          }
        });
      }on AppException catch (e) {
        emit(StreamOff());
      }
    });

    on<StartStreamEvent>((event, emit) async {
      try {
        await followRepository
            .startStreaming()
            .then((value) => emit(StreamOn()));
      } on AppException catch (e) {
        // emit(StreamOff());
      }
    });

    on<StopStreamEvent>((event, emit) async {
      try {
        await followRepository.stopStreaming().then((value) => emit(StreamOff()));
      } on AppException catch (e) {
        // emit(StreamError());
      }
    });

  }
}
