import 'package:flutter/material.dart';

class HoverAnimation extends StatefulWidget {
  final child;
  final duration;
  final double x;
  final double y;
  final double shakeHeight;

  const HoverAnimation({
    this.child,
    this.duration,
    required this.x,
    required this.y,
    required this.shakeHeight,
  });

  @override
  State<StatefulWidget> createState() => _HoverAnimation();
}

class _HoverAnimation extends State<HoverAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: widget.shakeHeight).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.repeat(reverse: true);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double y = 0;
        if (animation.value != widget.shakeHeight) {
          y = animation.value - (widget.shakeHeight / 2);
        }
        return Transform.translate(
          offset: Offset(widget.x, widget.y + y),
          child: widget.child,
        );
      },
    );
  }
}
