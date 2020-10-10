import 'package:flutter/material.dart';

class ButtonSmallPrimary extends StatelessWidget {
  ButtonSmallPrimary({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.stretch,
    this.isDisabled,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool stretch;
  final bool isDisabled;

  static const padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
