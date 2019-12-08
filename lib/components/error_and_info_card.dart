import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorAndInfoCard extends StatelessWidget {
  final String assetName;
  final String label;
  final Widget actionButton;
  const ErrorAndInfoCard(
      {Key key,
      @required this.assetName,
      @required this.label,
      this.actionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          this.assetName,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(height: 16.0),
        Text(
          this.label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 8.0),
        this.actionButton == null ? SizedBox(height: 0) : this.actionButton
      ],
    );
  }
}
