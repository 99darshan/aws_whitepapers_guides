import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final onPressed;
  const LoadMore({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      highlightedBorderColor: Colors.orange,
      splashColor: Colors.orange[200],
      padding: EdgeInsets.all(8.0),
      child: Text("Show More"),
      //color: Colors.orange,
      borderSide: BorderSide(color: Colors.orange),
      onPressed: this.onPressed,
    );
  }
}
