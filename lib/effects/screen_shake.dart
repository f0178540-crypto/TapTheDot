import 'dart:math';
import 'package:flutter/material.dart';
import '../core/gameplay_signals.dart';

class ScreenShake {
  double _time = 0;
  double intensity = 0;

  ScreenShake() {
    GameplaySignals.I.onPerfectHit(() {
      trigger(4);
    });

    GameplaySignals.I.onComboBreak(() {
      trigger(8);
    });
  }

  void trigger(double strength) {
    intensity = strength;
    _time = 0.15;
  }

  Offset update(double dt) {
    if (_time <= 0) return Offset.zero;
    _time -= dt;
    final rng = Random();
    return Offset(
      (rng.nextDouble() - 0.5) * intensity,
      (rng.nextDouble() - 0.5) * intensity,
    );
  }
}
