import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class DottedAvatar extends StatelessWidget {
  const DottedAvatar({@required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: radius,
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
              radius: radius - 2,
              backgroundColor: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}
