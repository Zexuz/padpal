import 'package:flutter/material.dart';

class RadioButtonInput<T> extends StatelessWidget {
  const RadioButtonInput({
    @required this.text,
    @required this.groupValue,
    @required this.value,
    @required this.onChanged,
  });

  final String text;
  final T value;
  final ValueChanged<T> onChanged;
  final T groupValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: value == groupValue ? theme.primaryColor : Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: RadioListTile(
            activeColor: theme.primaryColor,
            toggleable: true,
            groupValue: groupValue,
            onChanged: onChanged,
            value: value,
            title: Text(this.text, style: theme.textTheme.button.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}