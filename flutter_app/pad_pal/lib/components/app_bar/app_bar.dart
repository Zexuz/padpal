import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    @required this.title,
    this.actions,
    this.leading,
  }) : preferredSize = Size.fromHeight(58.0);

  @override
  final Size preferredSize;

  final String title;
  final List<Widget> actions;
  final Widget leading;

  static const bottomBorderSize = 0.5;
  static const textColor = Colors.black;
  static const bgColor = Colors.white;
  static const lineColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: TextStyle(color: textColor)),
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: bgColor,
      shadowColor: Colors.transparent,
      bottom: PreferredSize(
          child: Container(
            color: lineColor,
            height: bottomBorderSize,
          ),
          preferredSize: const Size.fromHeight(0)),
      actions: actions,
    );
  }
}
