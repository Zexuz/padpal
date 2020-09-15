import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class LeaderAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const size = 24.0;
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    return CircleAvatar(
      radius: size * 1.2,
      backgroundColor: AppTheme.primary,
      child: CircleAvatar(
        radius: size * 1.09,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: size,
          backgroundImage: NetworkImage(url),
        ),
      ),
    );
  }
}