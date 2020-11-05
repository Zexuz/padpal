import 'package:flutter/material.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';

class ResultDivideTeamsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ResultDivideTeamsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Result",
      ),
      body: Text("Hello!"),
    );
  }
}
