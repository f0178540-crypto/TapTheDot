class TimeAttackRules {
  double timeLeft = 60.0;

  void reset() {
    timeLeft = 60.0;
  }

  bool update(double dt) {
    timeLeft -= dt;
    return timeLeft <= 0;
  }
}
