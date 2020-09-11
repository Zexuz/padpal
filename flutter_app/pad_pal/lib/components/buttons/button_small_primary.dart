import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_primary_base.dart';

class ButtonSmallPrimary extends ButtonPrimaryBase {
  ButtonSmallPrimary(
      {Key key, VoidCallback onPressed, String text, bool stretch = true})
      : super(onPressed: onPressed, text: text, stretch: stretch);

  //0076FF
  static final Color primary = Color.fromRGBO(0, 118, 255, 1.0);
  static final Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const fontSize = 14.0;

  static final TextStyle primaryTextStyle =
      TextStyle(fontSize: fontSize, color: white);

  static final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  @override
  Widget build(BuildContext context) {
    return buildInternal(context, primary, primaryTextStyle, 8.0);
  }
}
