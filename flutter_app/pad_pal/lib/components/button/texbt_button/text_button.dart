import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  TextButton({Key key, @required this.onPressed, @required this.text}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FlatButton(
      textColor: theme.primaryColor,
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
