import 'package:flutter/material.dart';

import 'message_form.dart';
import 'message_form_impl.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Mock"),
              Tab(text: "Real"),
            ],
          ),
        ),
        body: TabBarView(
          children: [MessageForm(), MessageFormReal()],
        ),
      ),
    );
  }
}
