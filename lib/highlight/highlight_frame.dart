import 'package:flutter/widgets.dart';

class HighlightFrame {
  final Offset position;
  final double radius;
  final int score;
  final int combo;
  final double t;

  HighlightFrame({
    required this.position,
    required this.radius,
    required this.score,
    required this.combo,
    required this.t,
  });
}
