import 'package:flutter/material.dart';
import 'package:pad_pal/screens/event/event_list/view/no_events_found_view.dart';

import 'avatar_demo.dart';
import 'button_demo.dart';
import 'card_demo.dart';
import 'flare_demo.dart';
import 'input_demo.dart';
import 'text_demo.dart';

class ComponentsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ComponentsPage());
  }

  final entries = const <Widget>[
    ButtonDemo(),
    InputDemo(),
    AvatarDemo(),
    CardDemo(),
    FlareDemo(),
    TextDemo(),
    Scaffold(body: NoEventFoundView()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Components demo"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 50,
              child: Center(
                child: RaisedButton(
                    child: Text(entries[index].runtimeType.toString()),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(builder: (context) => entries[index]),
                        )),
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
