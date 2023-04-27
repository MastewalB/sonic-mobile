import 'dart:io';
import 'package:equatable/equatable.dart';

class Recording extends Equatable {
  final FileSystemEntity file;
  final Duration fileDuration;
  late final String name;

  Recording({
    required this.file,
    required this.fileDuration,
  }) {

      name = file.path.split('/').last.split('.').first;
      // dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
  }

  @override
  List<Object?> get props => [file, fileDuration];

  @override
  bool? get stringify => true;
}
