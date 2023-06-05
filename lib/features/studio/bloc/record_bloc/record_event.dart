part of 'record_bloc.dart';

abstract class RecordEvent extends Equatable {
  const RecordEvent();
}

class StartRecordingEvent extends RecordEvent {
  @override
  List<Object?> get props => [];
}

class StopRecordingEvent extends RecordEvent {
  final String? newName;

  const StopRecordingEvent({
    this.newName,
  });

  @override
  List<Object?> get props => [];
}

class ListRecordingsEvent extends RecordEvent {
  @override
  List<Object?> get props => [];
}

class RemoveRecording extends RecordEvent {
  @override
  List<Object?> get props => [];
}
