import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class CardDemo extends StatelessWidget {
  const CardDemo();

  @override
  Widget build(BuildContext context) {
    final entries = [
      CustomCard(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Demo'),
      ),
      backgroundColor: Color(0xFFDDE2E9),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return entries[index];
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
