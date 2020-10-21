import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/components/button/button.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo();

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
    final text = const Text('Create an event!');

    return <Widget>[
      Button(
        child: text,
        type: ButtonType.primary,
        onPressed: onPress,
      ),
      Button(
        child: text,
        type: ButtonType.primary,
        large: false,
        onPressed: onPress,
      ),
      Button(
        child: text,
        type: ButtonType.secondary,
        onPressed: onPress,
      ),
      Button(
        child: text,
        type: ButtonType.secondary,
        large: false,
        onPressed: onPress,
      ),
      Button(
        child: text,
        type: ButtonType.light,
        onPressed: onPress,
      ),
      Button(
        child: text,
        type: ButtonType.light,
        large: false,
        onPressed: onPress,
      ),
      TextButton(onPressed: onPress, child: Text("Text button"))
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
