import 'dart:math';

import 'package:flutter/material.dart';

import 'hand.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class DrawnHand extends Hand {
  /// How thick the hand should be drawn, in logical pixels.
  final double thickness;

  const DrawnHand({
    super.key,
    required super.color,
    required super.size,
    required super.angleRadians,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _HandPainter(
            handSize: size,
            lineWidth: thickness,
            angleRadians: angleRadians,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _HandPainter extends CustomPainter {
  _HandPainter({
    required this.handSize,
    required this.lineWidth,
    required this.angleRadians,
    required this.color,
  });

  final double handSize;
  final double lineWidth;
  final double angleRadians;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final normalizedAngle = angleRadians - pi / 2;

    final length = size.shortestSide * 0.4 * handSize;

    final center = size.center(Offset.zero);
    final position =
        center + Offset(cos(normalizedAngle), sin(normalizedAngle)) * length;

    final linePainter = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(center, position, linePainter);
  }

  @override
  bool shouldRepaint(_HandPainter oldDelegate) =>
      oldDelegate.handSize != handSize ||
      oldDelegate.lineWidth != lineWidth ||
      oldDelegate.angleRadians != angleRadians ||
      oldDelegate.color != color;
}
