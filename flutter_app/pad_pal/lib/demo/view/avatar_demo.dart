import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class AvatarDemo extends StatelessWidget {
  const AvatarDemo();

  @override
  Widget build(BuildContext context) {
    final entries = [
      LeaderAvatar(),
      Avatar(),
      DottedAvatar(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar Demo'),
      ),
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
