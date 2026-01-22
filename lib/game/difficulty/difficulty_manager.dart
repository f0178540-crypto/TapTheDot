class DifficultyManager {
  double time = 0;

  void reset() {
    time = 0;
  }

  void update(double dt) {
    time += dt;
  }

  double spawnRateMultiplier() {
    if (time < 10) return 1;
    if (time < 25) return 1.4;
    if (time < 45) return 1.8;
    return 2.3;
  }

  double speedMultiplier() {
    if (time < 15) return 1;
    if (time < 35) return 1.3;
    return 1.6;
  }

  int maxTargets() {
    if (time < 20) return 3;
    if (time < 40) return 4;
    return 5;
  }
}
