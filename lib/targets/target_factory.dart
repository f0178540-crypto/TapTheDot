import 'dart:math';
import 'package:flutter/material.dart';

import 'base_target.dart';
import 'types/moving_dot.dart';
import 'types/static_dot.dart';
import 'types/bomb_dot.dart';
import 'types/split_dot.dart';
import 'types/time_dot.dart';

class TargetFactory {
  static final _rng = Random();

  static BaseTarget random(Size size, double radius) {
    final p = Offset(
      _rng.nextDouble() * (size.width - radius * 2) + radius,
      _rng.nextDouble() * (size.height - radius * 2) + radius,
    );

    final r = _rng.nextDouble();

    if (r < 0.15) {
      return BombDot(position: p, radius: radius);
    }
    if (r < 0.30) {
      return SplitDot(position: p, radius: radius);
    }
    if (r < 0.45) {
      return MovingDot(
        position: p,
        radius: radius,
        vx: (_rng.nextDouble() * 200 - 100),
        vy: (_rng.nextDouble() * 200 - 100),
      );
    }
    if (r < 0.60) {
      return TimeDot(position: p, radius: radius);
    }

    return StaticDot(position: p, radius: radius);
  }
}
