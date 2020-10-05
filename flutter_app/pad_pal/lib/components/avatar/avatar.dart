import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  Avatar({
    @required this.url,
    @required this.radius,
    @required this.borderWidth,
    this.color,
  })  : assert(url != null),
        assert(radius != null),
        assert(borderWidth != null);

  final double borderWidth;
  final String url;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? theme.primaryColor;

    return Material(
      elevation: 4.0,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: color,
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Material(
          elevation: 0.0,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Image.network(
            url,
            width: radius * 2,
          ),
        ),
      ),
    );
  }
}
