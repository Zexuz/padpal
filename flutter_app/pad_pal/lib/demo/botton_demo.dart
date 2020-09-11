import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';

class ButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Demo'),
      ),
      body: Builder(
        builder: (context) {
          final onPressed = () => {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Clicked!"),
                ))
              };

          return Center(
            child: Column(
              children: [
                Text("Primary Large buttons"),
                ButtonLargePrimary(
                  onPressed: onPressed,
                  text: "Wohaao!",
                ),
                const SizedBox(height: 4.0),
                ButtonLargePrimary(
                  onPressed: onPressed,
                  text: "Wohaao!",
                  stretch: false,
                ),
                const SizedBox(height: 4.0),
                Text("Primary small buttons"),
                ButtonSmallPrimary(
                  onPressed: onPressed,
                  text: "Wohaao!",
                ),
                const SizedBox(height: 4.0),
                ButtonSmallPrimary(
                  onPressed: onPressed,
                  text: "Wohaao!",
                  stretch: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
