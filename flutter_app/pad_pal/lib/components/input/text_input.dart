import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput({Key key, this.text = "", this.enabled = true, this.isValid = true}) : super(key: key);

  final bool enabled;
  final String text;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
