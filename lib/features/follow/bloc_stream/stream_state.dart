part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamInitial extends StreamState {
  @override
  List<Object> get props => [];
}


class StreamOn extends StreamState{
  @override
  List<Object> get props => [];
}

class StreamOff extends StreamState{
  @override
  List<Object> get props => [];
}