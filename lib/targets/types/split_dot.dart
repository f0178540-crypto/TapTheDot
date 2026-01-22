import 'dart:math';
import 'package:flutter/material.dart';
import '../base_target.dart';

class SplitDot extends BaseTarget {
  SplitDot({
    required super.position,
    required super.radius,
  });

  @override
  void update(double dt, Size size) {}

  @override
  List<BaseTarget>? split(Size size) {
    if (radius < 14) return null;

    final r = radius * 0.6;

    return [
      SplitDot(
        position: position + const Offset(12, 0),
        radius: r,
      ),
      SplitDot(
        position: position + const Offset(-12, 0),
        radius: r,
      ),
    ];
  }

  @override
  Color getColor() => Colors.orangeAccent;
}
