class SurvivalRules {
  double hazardTimer = 0;
  double hazardInterval = 3.5;

  void reset() {
    hazardTimer = 0;
    hazardInterval = 3.5;
  }

  bool update(double dt) {
    hazardTimer += dt;
    if (hazardTimer >= hazardInterval) {
      hazardTimer = 0;
      hazardInterval = (hazardInterval * 0.96).clamp(0.8, 10);
      return true; // trigger hazard
    }
    return false;
  }
}
