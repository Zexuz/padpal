import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class AvatarDemo extends StatelessWidget {
  const AvatarDemo();

  static const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
  static const size = 58.0;
  static const padding = 6.0;

  @override
  Widget build(BuildContext context) {
    final entries = [
      Center(
        child: Avatar(
          name: "Robin Edbom",
          radius: size,
          borderWidth: padding,
          url: url,
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          name: "Edu ASd",
          borderWidth: padding,
          url: "",
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          borderWidth: padding,
          name: "Robin Edbom",
          url: url,
          color: Colors.white,
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          borderWidth: padding,
          color: Colors.white,
          name: "Robin Oliver Edbom",
          url: "",
        ),
      ),
      DottedAvatar(radius: size),
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
