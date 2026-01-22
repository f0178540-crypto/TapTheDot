import 'package:flutter/material.dart';
import '../base_target.dart';

class TimeDot extends BaseTarget {
  TimeDot({
    required super.position,
    required super.radius,
  });

  @override
  void update(double dt, Size size) {}

  @override
  int bonusTimeMs() => 2000;

  @override
  Color getColor() => Colors.cyanAccent;
}
