import 'dart:math';

import 'package:flutter/material.dart';

class ClockTime extends StatelessWidget {
  final double angleRadians;
  final int clock;

  const ClockTime({super.key, required this.angleRadians, required this.clock});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: ClockTimePainter(
            angleRadians: angleRadians,
            clock: clock,
            color: Theme.of(context).colorScheme.onSurface,
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class ClockTimePainter extends CustomPainter {
  final double angleRadians;
  final int clock;
  final Color color;
  final TextDirection textDirection;

  const ClockTimePainter({
    required this.angleRadians,
    required this.clock,
    required this.color,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final normalizedAngle = angleRadians - pi / 2;

    final center = (Offset.zero & size).center;
    final alignmentFactor = size.width * 0.2;

    final position =
        center +
        Offset(cos(normalizedAngle), sin(normalizedAngle)) * alignmentFactor;

    final painter = TextPainter()
      ..text = TextSpan(
        text: clock.toString(),
        style: TextStyle(color: color),
      )
      ..textDirection = textDirection;

    painter.layout();

    painter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
