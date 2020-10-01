import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  TextButton({Key key, @required this.onPressed, @required this.text}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyText1.copyWith(color: theme.primaryColor),
          text: text,
        ),
      ),
    );
  }
}
