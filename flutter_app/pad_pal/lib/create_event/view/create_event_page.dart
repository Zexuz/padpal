import 'package:flutter/material.dart';

class CreateEventPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => CreateEventPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create event', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 0.5,
            ),
            preferredSize: const Size.fromHeight(0)),
      ),
      body: const Text('Create Event'),
    );
  }
}