import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_primary_base.dart';

class ButtonSmallPrimary extends ButtonPrimaryBase {
  ButtonSmallPrimary(
      {Key key,
      VoidCallback onPressed,
      String text,
      bool stretch = true,
      bool isDisabled = false})
      : super(
            onPressed: onPressed,
            text: text,
            stretch: stretch,
            isDisabled: isDisabled);

  static const padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return buildInternal(context, padding);
  }
}
