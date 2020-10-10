import 'package:flutter/material.dart';

class EventFilterPage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EventFilterPage());
  }

  const EventFilterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("This is the filter view"),
      ),
    );
  }
}
