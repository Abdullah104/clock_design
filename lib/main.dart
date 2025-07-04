import 'package:flutetr_clock_helper/customizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'analog_clock.dart';

void main() {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.macOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(ClockCustomizer((model) => AnalogClock(model: model)));
}
