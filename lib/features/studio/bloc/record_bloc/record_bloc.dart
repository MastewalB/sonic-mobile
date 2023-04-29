import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonic_mobile/models/models.dart';
import 'package:sonic_mobile/core/core.dart';

part 'record_event.dart';

part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final NotificationCubit notificationCubit;
  final _recordController = Record();

  RecordBloc({required this.notificationCubit}) : super(RecordInitial()) {
    on<RecordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<StartRecordingEvent>((event, emit) async {
      try {
        var status = await Permission.microphone.status;
        if (!status.isGranted) {
          await Permission.microphone.request();
        }
        String rootPath =
            await FileManager.getOrCreateFolder(Constants.recordingDirectory);
        String filePath =
            '$rootPath${DateTime.now().millisecondsSinceEpoch}.mp3';

        await _recordController.start(path: filePath);

        emit(RecordOnState());
      } catch (e) {
        emit(RecordingError());
      }
    });

    on<StopRecordingEvent>((event, emit) async {
      String? path = await _recordController.stop();

      if (path != null && event.newName != null) {
        File file = File(path);
        String newPath =
            await FileManager.renameFile(path, '${event.newName!}.mp3');
        file.renameSync(newPath);
      }
      emit(RecordStoppedState());
    });

    on<ListRecordingsEvent>((event, emit) async {
      emit(LoadingState());
      List<Recording> recordings = [];
      try {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        String recordingPath =
            await FileManager.getOrCreateFolder(Constants.recordingDirectory);
        final List<FileSystemEntity> files =
            Directory(recordingPath).listSync();

        for (final file in files) {
          recordings.add(
            Recording(
              file: file,
              fileDuration: Duration(seconds: 5),
            ),
          );
        }
        emit(RecordingsLoaded(recordings: recordings));
      } catch (e) {
        emit(RecordingError());
      }
    });
  }

  Stream<double> amplitudeStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      final ap = await _recordController.getAmplitude();
      yield ap.current;
    }
  }
}
