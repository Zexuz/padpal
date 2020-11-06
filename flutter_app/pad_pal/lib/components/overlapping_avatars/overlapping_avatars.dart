import 'package:flutter/material.dart';
import 'package:pad_pal/components/avatar/avatar.dart';

class OverlappingAvatar extends StatelessWidget {
  const OverlappingAvatar({
    Key key,
    @required this.avatar1,
    @required this.avatar2,
    this.horizontalPadding = true,
    this.verticalPadding = true,
  })  : assert(horizontalPadding || verticalPadding),
        super(key: key);

  final Avatar avatar1;
  final Avatar avatar2;
  final bool horizontalPadding;
  final bool verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        avatar1,
        Padding(
          padding:
              EdgeInsets.only(left: horizontalPadding ? avatar1.radius : 0, top: verticalPadding ? avatar1.radius : 0),
          child: avatar2,
        ),
      ],
    );
  }
}
