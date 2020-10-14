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
          radius: size,
          borderWidth: padding,
          url: url,
          fallback: "FB",
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          borderWidth: padding,
          url: "",
          fallback: "FB",
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          borderWidth: padding,
          url: url,
          color: Colors.white,
          fallback: "FB",
        ),
      ),
      Center(
        child: Avatar(
          radius: size,
          borderWidth: padding,
          color: Colors.white,
          url: "",
          fallback: "FB",
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
