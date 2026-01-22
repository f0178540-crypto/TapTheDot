import 'trail_point.dart';
import 'package:flutter/widgets.dart';

class TrailBuffer {
  final List<TrailPoint> _points = [];

  List<TrailPoint> get points => _points;

  void add(Offset p) {
    _points.add(TrailPoint(p));
  }

  void update(double dt) {
    for (final p in _points) {
      p.life -= dt;
    }
    _points.removeWhere((p) => p.life <= 0);
  }

  void clear() {
    _points.clear();
  }
}
