import 'package:aws_whitepapers_guides/services/download_service.dart';
import 'package:flutter/material.dart';

class DownloadsState extends ChangeNotifier {
  static final DownloadsState _singleton = DownloadsState._();
  Future<List<String>> _allDownloadedFilesName;
  Future<List<String>> get allDownloadedFilesName => _allDownloadedFilesName;

  DownloadsState._() {
    fetchAllDownloadedFilesName();
    notifyListeners();
  }

  fetchAllDownloadedFilesName() {
    _allDownloadedFilesName = DownloadService.getDownloadedFilesName();
    notifyListeners();
  }

  factory DownloadsState() {
    return _singleton;
  }

  deleteFile(String fileName) async {
    await DownloadService.deleteFile(fileName);
    // once an item is deleted the list containing all the downloaded file names should be updated as well,
    // we could re-fetch the files from local storage or just delete the item from the _allDownloadedFilesName List.
    fetchAllDownloadedFilesName();
    notifyListeners();
  }
}
