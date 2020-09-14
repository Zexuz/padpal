
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    );
  }
}

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

class InputDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = [
      TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Password",
        ),
      ),
      TextField(
        decoration: InputDecoration(
          hintText: "asd",
          border: OutlineInputBorder(),
          labelText: "Text input",
          helperText: "Helper text for text inputt",
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      TextField(
        obscureText: false,
        enabled: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Text input",
            counterText: "Counter text",
            hintText: "Hint text",
            helperText: "Helper text",
            prefixText: "PRefix text",
            semanticCounterText: "Semantic counter text",
            suffixText: "Suffix text"),
      ),
      TextField(
        enabled: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Disabled",
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Demo'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return entries[index];
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
