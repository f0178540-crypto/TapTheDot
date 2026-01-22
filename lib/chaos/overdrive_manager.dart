class OverdriveManager {
  bool active = false;
  double timeLeft = 0;

  void trigger(double seconds) {
    active = true;
    timeLeft = seconds;
  }

  void update(double dt) {
    if (!active) return;
    timeLeft -= dt;
    if (timeLeft <= 0) {
      active = false;
      timeLeft = 0;
    }
  }

  double scoreMultiplier() {
    return active ? 2.0 : 1.0;
  }

  double speedMultiplier() {
    return active ? 1.4 : 1.0;
  }
}
