part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();
}

class StreamInitialEvent extends StreamEvent{
  @override
  List<Object?> get props => [];
}

class StartStreamEvent extends StreamEvent {
  @override
  List<Object?> get props => [];
}

class StopStreamEvent extends StreamEvent {
  @override
  List<Object?> get props => [];
}
