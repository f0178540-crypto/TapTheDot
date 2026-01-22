import 'dot.dart';
import 'dart:ui';

class HitDetection {
  bool checkHit(Offset tap, Dot dot) {
    return dot.hit(tap);
  }
}
