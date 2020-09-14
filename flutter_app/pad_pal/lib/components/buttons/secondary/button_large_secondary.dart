import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class ButtonLargeSecondary extends StatelessWidget {
  ButtonLargeSecondary(
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
      color: AppTheme.secondaryButtonColor,
      textColor: AppTheme.secondaryButtonTextColor,
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: isDisabled ? null : onPressed,
    );
  }
}
