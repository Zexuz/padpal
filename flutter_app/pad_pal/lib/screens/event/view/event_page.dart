import 'package:flutter/material.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/components/components.dart';
import 'package:pad_pal/screens/create_event/create_event.dart';
import 'package:pad_pal/theme.dart';

import 'event_filter_page.dart';

class EventPage extends StatelessWidget {
  const EventPage();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EventPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Events nearby',
        leading: IconButton(
          icon: Icon(Icons.filter_alt, color: Colors.black),
          onPressed: () => Navigator.push(context, EventFilterPage.route()),
        ),
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
