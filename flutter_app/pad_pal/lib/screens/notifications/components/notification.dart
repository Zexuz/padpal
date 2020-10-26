import 'package:flutter/material.dart';
import 'package:pad_pal/components/components.dart';

class Notification extends StatelessWidget {
  const Notification({
    @required this.title,
    @required this.imgUrl,
    @required this.label,
    @required this.onPrimaryPressed,
    this.onSecondaryPressed,
  })  : assert(title != null),
        assert(label != null),
        assert(onPrimaryPressed != null);

  final String title;
  final String label;
  final String imgUrl;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  static const radius = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = 25.0;

    final onlyOneAction = onSecondaryPressed == null;

    final primaryIcon = onlyOneAction
        ? Icon(
            Icons.arrow_forward_ios,
            size: iconSize,
          )
        : Icon(
            Icons.check,
            color: Colors.white,
            size: iconSize,
          );

    final primFillColor = onlyOneAction ? Colors.transparent : theme.primaryColor;

    return Row(
      children: [
        Avatar(
          radius: radius,
          name: "TODO", // TODO FIX NAME
          url: imgUrl,
          borderWidth: 0,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.headline6),
              Text(label, style: theme.textTheme.bodyText1),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (this.onSecondaryPressed != null)
              _IconButton(
                onPressed: onSecondaryPressed,
                child: Icon(
                  Icons.cancel,
                  size: iconSize,
                ),
                fillColor: Colors.grey,
              ),
            _IconButton(
              onPressed: onPrimaryPressed,
              child: primaryIcon,
              fillColor: primFillColor,
            )
          ],
        )
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    @required this.onPressed,
    @required this.fillColor,
    @required this.child,
  });

  final Widget child;
  final VoidCallback onPressed;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: fillColor,
      highlightElevation: 0,
      child: child,
      padding: EdgeInsets.all(7.0),
      shape: CircleBorder(),
    );
  }
}
