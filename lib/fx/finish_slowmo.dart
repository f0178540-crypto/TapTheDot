class FinishSlowMo {
  double factor = 1.0;
  double life = 0;

  void trigger() {
    factor = 0.25;
    life = 0.6;
  }

  void update(double dt) {
    if (life > 0) {
      life -= dt;
      if (life <= 0) factor = 1.0;
    }
  }

  bool get active => life > 0;
}
