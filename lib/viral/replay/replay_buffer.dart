import 'package:flutter/widgets.dart';

class ReplayFrame {
  final Offset dotPos;
  final double radius;
  final int score;

  ReplayFrame(this.dotPos, this.radius, this.score);
}

class ReplayBuffer {
  final int maxFrames;
  final List<ReplayFrame> _frames = [];

  ReplayBuffer({this.maxFrames = 180}); // ~3s @60fps

  void push(ReplayFrame f) {
    _frames.add(f);
    if (_frames.length > maxFrames) {
      _frames.removeAt(0);
    }
  }

  List<ReplayFrame> snapshot() {
    return List<ReplayFrame>.from(_frames);
  }

  void clear() {
    _frames.clear();
  }
}
