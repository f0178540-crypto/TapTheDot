import 'package:flutter/material.dart';

abstract class BaseTarget {
  Offset position;
  double radius;

  BaseTarget({
    required this.position,
    required this.radius,
  });

  void update(double dt, Size size);

  bool hit(Offset p) {
    return (p - position).distance <= radius;
  }

  bool isFatal() => false;

  int bonusTimeMs() => 0;

  List<BaseTarget>? split(Size size) => null;

  Color getColor();
}
