import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final onPressed;
  const GradientButton(
      {Key key, @required this.buttonText, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: better gradient color,
    // TODO: understand box constraint, remove the hardcoded min width height
    return RaisedButton(
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Text(
            this.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
