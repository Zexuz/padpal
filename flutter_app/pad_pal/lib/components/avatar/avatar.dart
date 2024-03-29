import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pad_pal/theme.dart';

class Avatar extends StatelessWidget {
  Avatar({
    @required this.url,
    @required this.name,
    @required this.radius,
    @required this.borderWidth,
    this.onTap,
    this.innerBorderWidth = 0,
    this.elevation = 4.0,
    this.color,
  })  : assert(url != null),
        assert(name != null),
        assert(radius != null),
        assert(borderWidth != null);

  final double borderWidth;
  final String url;
  final String name;
  final double radius;
  final Color color;
  final double elevation;
  final double innerBorderWidth;
  final VoidCallback onTap;

  static String _getInitials(String name) {
    final parts = name.split(" ");
    final buffer = StringBuffer();

    if (parts[0].length == 3) {
      return parts[0];
    }

    for (var i = 0; i < parts.length.clamp(0, 3); i++) {
      buffer.write(parts[i][0].toUpperCase());
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? theme.primaryColor;

    final imageWidth = (radius * 2) - (innerBorderWidth + borderWidth);

    final fbSize = 40.0;

    return Material(
      elevation: elevation,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(borderWidth),
          child: Material(
            elevation: 0.0,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(innerBorderWidth),
              child: Material(
                elevation: 0.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Container(
                  height: imageWidth,
                  width: imageWidth,
                  child: Builder(
                    builder: (context) {
                      if (url == "") {
                        return FittedBox(
                          child: SizedBox(
                            height: fbSize,
                            width: fbSize,
                            child: CustomPaint(
                              painter: _Paint(
                                context: context,
                                text: _getInitials(name),
                              ),
                            ),
                          ),
                        );
                      }

                      return CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (context, url) => CircularProgressIndicator(
                          backgroundColor: AppTheme.primary,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          size: imageWidth,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Paint extends CustomPainter {
  _Paint({@required this.context, @required this.text});

  final BuildContext context;
  final String text;

  @override
  void paint(Canvas canvas, Size size) {
    final theme = Theme.of(context);

    final textSpan = TextSpan(
      text: text,
      style: theme.textTheme.headline3.copyWith(color: theme.primaryColor),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    canvas.drawRect(Offset.zero & size, Paint()..color = AppTheme.secondaryColorOrange);

    final offset =
        Offset((size.width / 2) - textPainter.size.width / 2, (size.height / 2) - textPainter.size.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_Paint oldDelegate) => oldDelegate.context != context && oldDelegate.text != text;
}
