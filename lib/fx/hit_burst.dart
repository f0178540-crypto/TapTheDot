import 'package:flutter/widgets.dart';

class HitBurst {
  Offset? position;
  double life = 0;

  void trigger(Offset p) {
    position = p;
    life = 0.18;
  }

  void update(double dt) {
    if (life > 0) life -= dt;
  }

  bool get active => life > 0 && position != null;
}
