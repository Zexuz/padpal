import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';

class ButtonDemo extends StatelessWidget {
  final _onPressed = () => {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Primary Large buttons"),
            ButtonLargePrimary(
              onPressed: _onPressed,
              text: "Wohaao!",
            ),
            const SizedBox(height: 4.0),
            ButtonLargePrimary(
              onPressed: _onPressed,
              text: "Wohaao!",
              stretch: false,
            ),
            const SizedBox(height: 4.0),
            Text("Primary small buttons"),
            ButtonSmallPrimary(
              onPressed: _onPressed,
              text: "Wohaao!",
            ),
            const SizedBox(height: 4.0),
            ButtonSmallPrimary(
              onPressed: _onPressed,
              text: "Wohaao!",
              stretch: false,
            ),
          ],
        ),
      ),
    );
  }
}
