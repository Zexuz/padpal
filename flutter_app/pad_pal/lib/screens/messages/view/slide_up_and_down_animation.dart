import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SlideUpAndDownAnimiation extends StatefulWidget {
  const SlideUpAndDownAnimiation({
    Key key,
    @required this.scrollController,
    @required this.child,
  }) : super(key: key);

  final ScrollController scrollController;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _SlideUpAndDownAnimationState();
}

class _SlideUpAndDownAnimationState extends State<SlideUpAndDownAnimiation> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> offset;
  Animation<double> opacity;

  bool isActive = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset(0.0, 1.675), end: Offset(0.0, 0.0)).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutQuad,
    ));

    final _controller = widget.scrollController;

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && isActive) {
        setState(() {
          isActive = false;
        });
      }
    });

    _controller.addListener(() {
      if (!isActive && _controller.offset > 300) {
        animationController.forward();
        setState(() {
          isActive = true;
        });
      }

      if (isActive && _controller.offset < 300) {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: widget.child,
    );
  }
}
