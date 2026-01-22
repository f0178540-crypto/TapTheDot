import 'package:flutter/widgets.dart';

class TrailPoint {
  final Offset position;
  double life;

  TrailPoint(this.position, {this.life = 0.25});
}
