import 'package:flutter/widgets.dart';

class NearMissDetector {
  // koliko blizu ivice se računa kao clutch (procenat radijusa)
  final double edgeThreshold = 0.18;

  bool isClutch(Offset tap, Offset center, double radius) {
    final dist = (tap - center).distance;
    final edgeStart = radius * (1 - edgeThreshold);
    return dist >= edgeStart && dist <= radius;
  }
}
