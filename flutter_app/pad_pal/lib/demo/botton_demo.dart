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
    final onPress = () => Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('Clicked!'),
        ));
    const String text = 'Wohaao!';

    return <Widget>[
      ButtonLargePrimary(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonSmallPrimary(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonLargeSecondary(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonSmallSecondary(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonLargeLight(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonSmallLight(onPressed: onPress, text: text, stretch: true, isDisabled: false),
      ButtonLargeLight(onPressed: onPress, text: text, stretch: true, isDisabled: true),
      ButtonSmallLight(onPressed: onPress, text: text, stretch: true, isDisabled: true),
    ];
  }

  Widget builder(BuildContext context) {
    final List<Widget> entries = getEntries(context);

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
