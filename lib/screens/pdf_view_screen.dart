import 'dart:io';
import 'package:aws_whitepapers_guides/components/shimmer_list.dart';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/services/download_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final WhitepaperData
      currentWhitepaper; // when view pdf is clicked from bookmarks and whitepapers screen
  final String whitepaperFileName; // when viewed from downloads screen
  PdfViewScreen({Key key, this.currentWhitepaper, this.whitepaperFileName})
      : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currentWhitepaper != null
              ? widget.currentWhitepaper.item.additionalFields.docTitle
              : widget.whitepaperFileName,
        ),
        actions: <Widget>[
          widget.currentWhitepaper != null
              ? IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () {
                    DownloadService.downloadWhitepaper(
                        widget.currentWhitepaper);
                  },
                )
              : SizedBox(width: 0, height: 0)
        ],
      ),
      body: FutureBuilder(
        future: widget.currentWhitepaper != null
            ? createFileOfPdfUrl()
            : DownloadService.getDownloadedFilePath(widget.whitepaperFileName),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
            return ShimmerList();
          } else {
            print('does snapshot when downloading file has error : ' +
                snapshot.hasError.toString());
            if (snapshot.hasError) {
              // TODO: error card on downloading
              return Text(snapshot.error.toString());
            } else {
              print(snapshot.data);
              return PDFView(
                filePath: widget.currentWhitepaper != null
                    ? snapshot.data.path
                    : snapshot.data,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: false,
                nightMode: false,
                onRender: (_pages) {},
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  //.complete(pdfViewController);
                },
                onPageChanged: (int page, int total) {
                  print('page change: $page/$total');
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<File> createFileOfPdfUrl() async {
    try {
      final filename = widget.currentWhitepaper.item.name;
      var request = await HttpClient().getUrl(
          Uri.parse(widget.currentWhitepaper.item.additionalFields.primaryURL));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } on SocketException catch (_) {
      throw new SocketException("Poor or NO Internet Connection !!");
      //print("Unstable Internet Connection !!");
    } on Exception catch (e) {
      print(e.toString());
      throw new Exception("Error Downloading File..." + e.toString());
    }
  }
}
