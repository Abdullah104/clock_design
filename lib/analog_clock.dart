import 'dart:async';

import 'package:clock_design/clock_time.dart';
import 'package:clock_design/drawn_hand.dart';
import 'package:flutetr_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

final radiansPerTick = radians(360 / 60);
final radiansPerHour = radians(360 / 12);

class AnalogClock extends StatefulWidget {
  final ClockModel model;

  const AnalogClock({super.key, required this.model});

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock>
    with SingleTickerProviderStateMixin {
  var _now = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _updateTime();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBright = theme.brightness == Brightness.light;
    final customTheme = theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        // Hour hand
        primary: isBright ? Color(0xFF000521) : Color(0xFFFFFFFF),

        // Second hand
        secondary: isBright ? Color(0xFFFF0000) : Color(0xFFFF0000),

        // Background color
        surface: isBright ? Color(0xFFFFFFFF) : Color(0xFF000521),
      ),

      // Minute hand
      highlightColor: isBright ? Color(0xFF000521) : Color(0xFFFFFFFF),
    );

    final time = DateFormat.Hms().format(DateTime.now());

    final weekdays = [
      'SUNDAY',
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
    ];

    final months = {
      1: 'JAN',
      2: 'FEB',
      3: 'MAR',
      4: 'APR',
      5: 'MAY',
      6: 'JUN',
      7: 'JUL',
      8: 'AUG',
      9: 'SEP',
      10: 'OCT',
      11: 'NOV',
      12: 'DEC',
    };

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: customTheme.colorScheme.primary, width: 10),
          // color: customTheme.colorScheme.surface,
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: customTheme.colorScheme.secondary.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),

            // Seconds hand
            DrawnHand(
              color: customTheme.colorScheme.secondary,
              size: .8,
              angleRadians: _now.second * radiansPerTick,
              thickness: 1,
            ),

            // Minutes hand.
            DrawnHand(
              color: customTheme.highlightColor,
              size: .72,
              angleRadians: _now.minute * radiansPerTick,
              thickness: 2,
            ),

            // // Hours hand.
            DrawnHand(
              color: customTheme.highlightColor,
              size: .5,
              angleRadians:
                  _now.hour * radiansPerHour +
                  (_now.minute / 60) * radiansPerHour,
              thickness: 4,
            ),
            ...List.generate(
              12,
              (index) => ClockTime(
                angleRadians: (index + 1) * radiansPerHour,
                clock: index + 1,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${weekdays[_now.weekday]}, ${months[_now.month]}',
                      style: TextStyle(
                        color: customTheme.primaryColor,
                        fontSize: 10,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: customTheme.primaryColor,
                      ),
                      child: Text(
                        _now.day.toString(),
                        style: TextStyle(
                          color: customTheme.colorScheme.surface,
                          fontSize: 9,
                          height: 1.15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: customTheme.colorScheme.secondary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();

      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }
}
