import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

enum SnackBarType { normal, success, warning, error }

class SnackBarFactory {
  static SnackBar buildSnackBar(String text, [SnackBarType type = SnackBarType.normal]) {
    Color color;
    switch (type) {
      case SnackBarType.normal:
        color = null;
        break;
      case SnackBarType.success:
        color = Colors.green;
        break;
      case SnackBarType.warning:
        color = AppTheme.secondaryColorOrange;
        // TODO: Handle this case.
        break;
      case SnackBarType.error:
        color = Colors.red;
        break;
    }

    return SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    );
  }
}
