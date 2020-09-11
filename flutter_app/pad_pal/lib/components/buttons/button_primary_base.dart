import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ButtonPrimaryBase extends StatelessWidget {
  ButtonPrimaryBase(
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

  @protected
  Widget buildInternal(BuildContext context, double padding) {
    final button = RaisedButton(
      padding: EdgeInsets.all(padding),
      child: Text(text),
      onPressed: isDisabled ? null : onPressed,
    );
    return stretch
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }
}
