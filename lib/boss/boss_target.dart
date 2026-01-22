import 'package:flutter/widgets.dart';

class BossTarget {
  Offset position;
  double radius;
  int hp;

  BossTarget({
    required this.position,
    this.radius = 40,
    this.hp = 8,
  });

  bool hit(Offset tap) {
    if ((tap - position).distance <= radius) {
      hp--;
      return true;
    }
    return false;
  }

  bool get isDead => hp <= 0;
}
