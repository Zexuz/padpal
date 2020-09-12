import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';
import 'package:dotted_border/dotted_border.dart';

class LeaderAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    return CircleAvatar(
      radius: 60,
      backgroundColor: AppTheme.primary,
      child: CircleAvatar(
        radius: 54,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(url),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    return CircleAvatar(
      radius: 50,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(url),
      ),
    );
  }
}

class DottedAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: 52,
            backgroundColor: AppTheme.secondaryColorOrange.withOpacity(0.12),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 1.0,
            ),
            DottedBorder(
              padding: EdgeInsets.all(1),
              borderType: BorderType.Circle,
              color: AppTheme.secondaryColorOrange,
              strokeWidth: 2.0,
              strokeCap: StrokeCap.butt,
              dashPattern: [7],
              radius: Radius.circular(50.0),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.secondaryColorOrange.withOpacity(0.12),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class AvatarDemo extends StatelessWidget {
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
