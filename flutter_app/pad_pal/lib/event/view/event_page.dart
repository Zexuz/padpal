import 'package:flutter/material.dart';
import 'package:pad_pal/create_event/view/create_event_page.dart';
import 'package:pad_pal/demo/card_demo.dart';
import 'package:pad_pal/theme.dart';

class EventPage extends StatelessWidget {
  const EventPage();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EventPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events nearby', style: TextStyle(color: Colors.black)),
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
        actions: [
          FlatButton(
            onPressed: () => {Navigator.of(context).push<void>(CreateEventPage.route())},
            child: Text(
              'Create',
              style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFDDE2E9),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: CustomCard(),
      ),
    );
  }
}
