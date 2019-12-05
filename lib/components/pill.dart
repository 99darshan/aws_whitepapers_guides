import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final Color backgroundColor;
  final Text text;

  const Pill({Key key, @required this.backgroundColor, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: new BorderRadius.all(Radius.circular(16.0))),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      //color: Colors.orange,
      child: text,
    );
  }
}
