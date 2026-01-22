import 'dart:math';

class CameraState {
  double scale = 1.0;

  void set(double v) {
    scale = max(0.85, min(1.35, v));
  }

  void reset() {
    scale = 1.0;
  }
}
