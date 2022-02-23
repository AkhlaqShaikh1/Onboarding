import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onboarding/constants/constants.dart';

class AnimatedIndicator extends StatefulWidget {
  final double size;
  final VoidCallback callback;
  final Duration duration;
  const AnimatedIndicator(
      {Key? key,
      this.size = 75,
      required this.callback,
      required this.duration})
      : super(key: key);

  @override
  _AnimatedIndicatorState createState() => _AnimatedIndicatorState();
}

class _AnimatedIndicatorState extends State<AnimatedIndicator>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          widget.callback();
        }
      });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: ProgressPainter(progress: _animation.value),
        );
      },
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({required this.progress});
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    var linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = blueColor
      ..strokeWidth = 3;

    var circlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = blueColor;

    final radians = (progress / 100) * 2 * pi;
    _drawShape(canvas, linePaint, circlePaint, -pi / 2, radians, size);
  }

  _drawShape(Canvas canvas, Paint linePaint, Paint circlePaint,
      double startAngle, double sweepRadians, Size size) {
    final centerX = size.width / 2, centerY = size.height / 2;
    final centerOffset = Offset(centerX, centerY);
    final radius = min(size.width, size.height) / 2;
    canvas.drawArc(Rect.fromCircle(center: centerOffset, radius: radius),
        startAngle, sweepRadians, false, linePaint);

    final x = radius * (1 + sin(sweepRadians)),
        y = radius * (1 - cos(sweepRadians));
    final circleOffset = Offset(x, y);
    canvas.drawCircle(circleOffset, 5, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
