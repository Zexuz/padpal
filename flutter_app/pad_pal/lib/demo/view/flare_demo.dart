import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlareDemo extends StatelessWidget {
  const FlareDemo();


  @override
  Widget build(BuildContext context) {
    return new FlareActor(
      "assets/success_check.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "Untitled",
    );
  }
}
