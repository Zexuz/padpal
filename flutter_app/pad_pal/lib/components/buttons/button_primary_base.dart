import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ButtonPrimaryBase extends StatelessWidget {
  ButtonPrimaryBase(
      {Key key,
        @required this.onPressed,
        @required this.text,
        this.stretch = true})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool stretch;

  static BorderRadius borderRadius = BorderRadius.circular(6.0);

  static final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.0),
  );

  @protected
  Widget buildInternal(
      BuildContext context, Color primary, TextStyle primaryTextStyle, double padding) {
    final button = RawMaterialButton(
      fillColor: primary,
      child: Padding(
        padding: EdgeInsets.all(padding), //TODO Check why we can't have padding that is less than 10
        child: Text(text, style: primaryTextStyle),
      ),
      onPressed: onPressed,
      shape: shape,
    );
    return stretch
        ? SizedBox(
      width: double.infinity,
      child: button,
    )
        : button;
  }
}