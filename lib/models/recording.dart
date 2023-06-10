import 'dart:io';
import 'package:sonic_mobile/models/models.dart';

class Recording extends Audio {
  final FileSystemEntity file;

  // final Duration fileDuration;
  late final String name;

  Recording(
    title,
    artistName,
    fileUrl, {
    required this.file,
    // required this.fileDuration,
  }) : super(title: title, artistName: artistName, fileUrl: fileUrl) {
    name = file.path.split('/').last.split('.').first;
    // dateTime = DateTime.fromMillisecondsSinceEpoch(millisecond);
  }

  @override
  List<Object?> get props => [file];

  @override
  bool? get stringify => true;
}
