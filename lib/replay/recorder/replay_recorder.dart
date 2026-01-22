import 'dart:ui';
import 'frame_buffer.dart';

class ReplayRecorder {
  final List<ReplayFrame> _frames = [];
  int maxFrames = 180; // ~3 seconds @60fps

  void addFrame(Image img, int timestampMs) {
    _frames.add(ReplayFrame(img, timestampMs));
    if (_frames.length > maxFrames) {
      _frames.removeAt(0);
    }
  }

  List<ReplayFrame> stop() {
    return List.from(_frames);
  }

  void reset() {
    _frames.clear();
  }
}
