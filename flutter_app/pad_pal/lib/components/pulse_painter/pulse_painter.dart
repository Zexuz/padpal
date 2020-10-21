import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class PulsePainter extends CustomPainter {
  final Animation<double> _animation;

  const PulsePainter(this._animation) : super(repaint: _animation);

  static const int numberOfRings = 2;
  static const Color color = AppTheme.primary;

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / (numberOfRings + 1))).clamp(0.0, 0.2);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / (numberOfRings + 1));

    final Paint paint = new Paint()..color = color.withOpacity(opacity);

    final Paint edgePainter = Paint()
      ..color = color.withOpacity(Curves.fastLinearToSlowEaseIn.transformInternal(opacity))
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawCircle(rect.center, radius, paint);
    canvas.drawCircle(rect.center, radius, edgePainter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = numberOfRings; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(PulsePainter oldDelegate) {
    return true;
  }
}
