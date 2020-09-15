import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class DottedAvatar extends StatelessWidget {
  const DottedAvatar();

  static const size = 24.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: size + 2,
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
