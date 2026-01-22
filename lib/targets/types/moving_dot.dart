import 'dart:math';
import 'package:flutter/material.dart';

import '../base_target.dart';

class MovingDot extends BaseTarget {
  double vx;
  double vy;

  MovingDot({
    required super.position,
    required super.radius,
    required this.vx,
    required this.vy,
  });

  @override
  void update(double dt, Size size) {
    position = Offset(position.dx + vx * dt, position.dy + vy * dt);

    if (position.dx < radius || position.dx > size.width - radius) {
      vx = -vx;
    }
    if (position.dy < radius || position.dy > size.height - radius) {
      vy = -vy;
    }
  }

  @override
  Color getColor() => Colors.blueAccent;
}
