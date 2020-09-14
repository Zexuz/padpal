import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';
import 'package:dotted_border/dotted_border.dart';

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

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const url = "https://www.fakepersongenerator.com/Face/female/female20161025116292694.jpg";
    const size = 24.0;

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

class DottedAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const size = 24.0;

    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: size + 2,
            //backgroundColor: Colors.black.withOpacity(0.12),
            backgroundColor: AppTheme.secondaryColorOrange.withOpacity(0.12),
          ),
        ),
        Center(
          child: DottedBorder(
            borderType: BorderType.Circle,
            color: AppTheme.secondaryColorOrange,
            strokeWidth: 1.0,
            strokeCap: StrokeCap.butt,
            dashPattern: [4],
            child: CircleAvatar(
              radius: size,
              backgroundColor: Colors.transparent,
            ),
          ),
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
