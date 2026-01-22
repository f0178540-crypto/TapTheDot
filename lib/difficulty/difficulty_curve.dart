class DifficultyCurve {
  double time = 0;

  void update(double dt) {
    time += dt;
  }

  double get spawnRate {
    if (time < 30) return 1.0;
    if (time < 60) return 1.3;
    if (time < 120) return 1.7;
    return 2.2;
  }

  bool get bossWindow {
    return time > 45 && time % 40 < 2;
  }
}
