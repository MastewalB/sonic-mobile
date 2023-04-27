part of 'record_bloc.dart';

abstract class RecordState extends Equatable {
  const RecordState();
}

class RecordInitial extends RecordState {
  @override
  List<Object> get props => [];
}

class RecordOnState extends RecordState {
  @override
  List<Object> get props => [];
}

class RecordStoppedState extends RecordState {
  @override
  List<Object> get props => [];
}

class RecordingError extends RecordState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RecordState {
  @override
  List<Object> get props => [];
}

class RecordingsLoaded extends RecordState {
  final List<Recording> recordings;

  const RecordingsLoaded({
    required this.recordings,
  });

  List<Recording> get recordingList {
    recordings.sort((a, b) {
      return b.name.compareTo(a.name);
    });
    return recordings;
  }

  @override
  List<Object> get props => [];
}
