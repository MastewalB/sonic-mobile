import 'dart:io';
import 'package:sonic_mobile/models/models.dart';

class Recording extends Audio {
  final FileSystemEntity file;
  // final Duration fileDuration;
  late final String name;

  Recording(
    super.title,
    super.artistName,
    super.fileUrl, {
    required this.file,
    // required this.fileDuration,
  }) {
    name = file.path.split('/').last.split('.').first;
    // dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
  }

  @override
  List<Object?> get props => [file];

  @override
  bool? get stringify => true;
}
