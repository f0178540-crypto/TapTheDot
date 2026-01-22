import 'package:flutter/material.dart';
import '../base_target.dart';

class BombDot extends BaseTarget {
  BombDot({
    required super.position,
    required super.radius,
  });

  @override
  void update(double dt, Size size) {}

  @override
  bool isFatal() => true;

  @override
  Color getColor() => Colors.redAccent;
}
