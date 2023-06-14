part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamInitial extends StreamState {
  @override
  List<Object> get props => [];
}


class StreamSuccess extends StreamState{
  @override
  List<Object> get props => [];
}

class StreamError extends StreamState{
  @override
  List<Object> get props => [];
}