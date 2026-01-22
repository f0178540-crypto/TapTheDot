import 'package:flutter/widgets.dart';

class RiskTarget {
  final Offset position;
  final double radius;

  RiskTarget(this.position, this.radius);

  bool hit(Offset tap) {
    return (tap - position).distance <= radius;
  }
}
