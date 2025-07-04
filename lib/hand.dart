import 'package:flutter/widgets.dart';

/// A base class for an analog hand-drawing widget.
///
/// This only draws one hand of the analog clock. Put it in a [Stack] to have
/// more than one hand.
abstract class Hand extends StatelessWidget {
  const Hand({
    super.key,
    required this.color,
    required this.size,
    required this.angleRadians,
  });

  /// Hand color.
  final Color color;

  /// Hand length, as a percent of the smaller side of the clock's parent
  /// container.
  final double size;

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  final double angleRadians;
}
