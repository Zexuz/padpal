import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class TextButton extends StatelessWidget {
  TextButton(
      {Key key,
      @required this.onPressed,
      @required this.text})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: AppTheme.Current.primaryColor,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
