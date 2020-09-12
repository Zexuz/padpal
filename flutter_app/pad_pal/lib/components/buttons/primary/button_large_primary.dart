import 'package:flutter/material.dart';

class ButtonLargePrimary extends StatelessWidget {
  ButtonLargePrimary(
      {Key key,
      @required this.onPressed,
      @required this.text,
      @required this.stretch,
      @required this.isDisabled})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool stretch;
  final bool isDisabled;

  static const padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: isDisabled ? null : onPressed,
    );
  }
}
