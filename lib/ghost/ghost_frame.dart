import 'package:flutter/widgets.dart';

class GhostFrame {
  final Offset position;
  final double time; // seconds since run start

  GhostFrame(this.position, this.time);
}
