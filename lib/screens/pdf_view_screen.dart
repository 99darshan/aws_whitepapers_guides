import 'package:flutter/material.dart';

class PdfViewScreen extends StatefulWidget {
  PdfViewScreen({Key key}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("pdf View"),
    );
  }
}
