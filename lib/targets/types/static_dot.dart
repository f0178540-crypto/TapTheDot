import 'package:flutter/material.dart';
import '../base_target.dart';

class StaticDot extends BaseTarget {
  StaticDot({
    required super.position,
    required super.radius,
  });

  @override
  void update(double dt, Size size) {}

  @override
  Color getColor() => Colors.greenAccent;
}
