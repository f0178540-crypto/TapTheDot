class DifficultyManager {
  double _multiplier = 1.0;

  void reset() {
    _multiplier = 1.0;
  }

  void increase() {
    _multiplier += 0.05;
  }

  double spawnRateMultiplier() {
    return _multiplier;
  }
}
