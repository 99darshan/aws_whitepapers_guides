import 'dart:io';

import 'package:aws_whitepapers_guides/models/whitepaperData.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  // this download function reference will be passed to any view pdf screen as well
  static Future downloadWhitepaper(WhitepaperData whitepaper) async {
    var taskId = await FlutterDownloader.enqueue(
      url: whitepaper.item.additionalFields.primaryURL,
      fileName: whitepaper.item.name,
      savedDir: await _findLocalPath(),
      showNotification: true,
      openFileFromNotification: true,
    );
    //_showDownloadDialog(article);
  }

  // TODO: answer this https://stackoverflow.com/questions/51776109/how-to-get-the-absolute-path-to-the-download-folder/51777119
  static Future<String> _findLocalPath() async {
    // getExternalStorageDirectory() use this if to save to downloads dir
    //final directory = await getApplicationDocumentsDirectory();
    // getExternalStorageDirectory() gives /storage/emulated/0/Android/data/com.example.core_research/files
    final directory = await getExternalStorageDirectory();
    print(directory.path);
    String path = directory.path +
        '/Download'; // TODO: change directory folder name to AWSWhitepapers
    final saveDir = Directory(path);
    bool dirExists = await saveDir.exists();
    if (!dirExists) {
      saveDir.create();
    }
    return saveDir.path;
  }
}
