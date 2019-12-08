import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final onPressed;
  const LoadMore({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      highlightedBorderColor: Theme.of(context).accentColor,
      splashColor: Theme.of(context).accentColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Show More",
        style: Theme.of(context).textTheme.button,
      ),
      color: Theme.of(context).accentColor,
      borderSide: BorderSide(color: Theme.of(context).accentColor),
      onPressed: this.onPressed,
    );
  }
}
