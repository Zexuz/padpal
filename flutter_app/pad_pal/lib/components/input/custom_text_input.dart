import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key key,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.controller,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final bool readOnly;
  final bool autofocus;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      maxLines: null,
      autofocus: this.autofocus,
      readOnly: this.readOnly,
      onTap: this.onTap,
      focusNode: this.focusNode,
      controller: this.controller,
      onChanged: onChanged,
      decoration: AppTheme.graySearch.copyWith(
        contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        hintText: "Search",
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(6.0),
          ),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
