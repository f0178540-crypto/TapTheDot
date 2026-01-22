import 'dart:math';
import 'package:flutter/widgets.dart';

class BossDot {
  Offset position;
  double radius;
  int hp;

  BossDot({
    required this.position,
    required this.radius,
    required this.hp,
  });

  static BossDot random(Size size, double radius, int hp) {
    final rnd = Random();
    final x = rnd.nextDouble() * (size.width - radius * 2) + radius;
    final y = rnd.nextDouble() * (size.height - radius * 2) + radius;
    return BossDot(position: Offset(x, y), radius: radius, hp: hp);
  }

  bool hit(Offset tap) {
    if ((tap - position).distance <= radius) {
      hp--;
      return true;
    }
    return false;
  }

  bool get isDead => hp <= 0;
}
