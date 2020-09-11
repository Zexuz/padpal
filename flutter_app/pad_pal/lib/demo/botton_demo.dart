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
        builder: builder,
      ),
    );
  }

  List<Widget> getEntries(BuildContext context) {
    final onPress = () =>
    {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Clicked!"),
      ))
    };
    final text = "Wohaao!";

    return [
      ButtonLargePrimary(onPressed: onPress, text: text, stretch: true, isDisabled: false,),
      ButtonLargePrimary(onPressed: onPress, text: text, stretch: true, isDisabled: true),
      ButtonSmallPrimary(onPressed: onPress, text: text, stretch: true, isDisabled: false,),
      ButtonSmallPrimary(onPressed: onPress, text: text, stretch: true, isDisabled: true),
    ];
  }

  Widget builder(context) {

    final entries = getEntries(context);


    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return entries[index];
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
