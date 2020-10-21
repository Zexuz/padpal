import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

enum ButtonType { primary, secondary, light }

class Button extends StatelessWidget {
  const Button({
    Key key,
    @required this.child,
    @required this.type,
    large = true,
  })  : _large = large,
        super(key: key);

  // const Button.text({
  //   Key key,
  //   @required this.child,
  //   large = true,
  // })  : _filled = false,
  //       color = null,
  //       _large = large,
  //       type = ButtonType.light,
  //       super(key: key);

  final Widget child;
  final ButtonType type;

  final bool _large;

  Color _getTextColor(ButtonType type, ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return Colors.white;
      case ButtonType.secondary:
        return Colors.black;
      case ButtonType.light:
        return theme.primaryColor;
    }
    throw Exception("No color found for type $type");
  }

  Color _getFillColor(ButtonType type, ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.primaryColor;
      case ButtonType.secondary:
        return theme.accentColor;
      case ButtonType.light:
        return AppTheme.light;
    }
    throw Exception("No color found for type $type");
  }

  Color _getSplashColor(ButtonType type, ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.primaryColor;
      case ButtonType.secondary:
        return Colors.black12;
      case ButtonType.light:
        return Colors.black12;
    }
    throw Exception("No color found for type $type");
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = () => {};
    final theme = Theme.of(context);

    final color = _getFillColor(type, theme);
    final size = _large ? 48.0 : 36.0;

    final textTheme = theme.textTheme.button.copyWith(
      color: _getTextColor(type, theme),
    );

    return FlatButton(
      child: DefaultTextStyle(
        child: this.child,
        style: textTheme,
      ),
      onPressed: onPressed,
      height: size,
      color: color,
      splashColor: _getSplashColor(type, theme),
    );
  }
}
