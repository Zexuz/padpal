import 'package:flutter/material.dart';

class FocusRemover extends StatelessWidget {
  FocusRemover({
    Key key,
    @required this.focusNode,
    @required this.child,
  })  : assert(focusNode != null),
        assert(child != null),
        super(key: key);

  final Widget child;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: child,
    );
  }
}
