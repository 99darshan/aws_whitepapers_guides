import 'dart:io';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/services/download_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final WhitepaperData currentWhitepaper;
  PdfViewScreen({Key key, @required this.currentWhitepaper}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: '${widget.currentWhitepaper.item.name}',
            child: Text(
              widget.currentWhitepaper.item.additionalFields.docTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(color: Colors.white),
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              DownloadService.downloadWhitepaper(widget.currentWhitepaper);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: createFileOfPdfUrl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print('does snapshot when downloading file has error : ' +
                snapshot.hasError.toString());
            if (snapshot.hasError) {
              // TODO: error card on downloading
              return Text(snapshot.error.toString());
            } else {
              print(snapshot.data);
              return PDFView(
                filePath: snapshot.data.path,
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
