import 'package:flutter/material.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';

import 'message_form_impl.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Messages",
        ),
        body: MessageFormReal(),
      ),
    );
  }
}
