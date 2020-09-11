import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class ButtonLargeLight extends StatelessWidget {
  ButtonLargeLight(
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
      color: AppTheme.light,
      textColor: AppTheme.primary,
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: isDisabled ? null : onPressed,
    );
  }
}
