import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar();

  static const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
  static const size = 24.0;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: size,
      child: CircleAvatar(
        radius: size,
        backgroundColor: Colors.black,
        child: ClipOval(
            child: Image.network(
          url,
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
