import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class CreateEventOtherInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CourtTypeInput(),
        const SizedBox(
          height: 48,
        ),
        _PriceInput(),
        const SizedBox(
          height: 48,
        ),
        TextFormField(
          maxLines: 8, // TODO make some logging and check if this needs to be bigger!
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Leave a message',
              hintText: "This text will not be visible to people outside of this event"
          ),
        )
      ],
    );
  }
}

class _PriceInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "kr",
        border: OutlineInputBorder(),
        labelText: 'Price per person',
      ),
    );
  }
}

class _CourtTypeInput extends StatefulWidget {
  @override
  __CourtTypeInputState createState() => __CourtTypeInputState();
}

class __CourtTypeInputState extends State<_CourtTypeInput> {
  String groupValue = "";

  bool someBooleanValue = false;

  _onRadioButtonTap(String newValue) {
    if (newValue == null) return;
    setState(() {
      groupValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioButtonInput<String>(
          text: "Indoors",
          value: "indoors",
          groupValue: groupValue,
          onChanged: _onRadioButtonTap,
        ),
        const SizedBox(height: 12),
        RadioButtonInput<String>(
          text: "Outdoors",
          value: "outdoors",
          groupValue: groupValue,
          onChanged: _onRadioButtonTap,
        ),
      ],
    );
  }
}