import 'package:flutter/material.dart';

class ButtonLargePrimary extends StatelessWidget {
  ButtonLargePrimary(
      {Key key,
      @required this.onPressed,
      @required this.text,
      this.stretch,
      this.isDisabled})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool stretch; // TODO remove stretch
  final bool isDisabled;// TODO remove isDisabled, let onPress dictate this

  static const padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
