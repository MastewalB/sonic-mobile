import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future<String> getOrCreateFolder(String folderName) async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/$folderName');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if (await dir.exists()) {
      return dir.path;
    } else {
      await dir.create(recursive: true);
      return dir.path;
    }
  }

  static Future<String> renameFile(String filePath, String fileName) async {
    try {
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        await Permission.manageExternalStorage.status;
      }
      String dir = path.dirname(filePath);
      String newPath = path.join(dir, fileName);
      return newPath;
    } catch (e) {
      rethrow;
    }
  }

// List listDir(String folderPath) async {
//   var dir = Directory(folderPath);
//   var exists = await dir.exists();
//
//   if(exists){
//     dir.
//   }
// }
}
