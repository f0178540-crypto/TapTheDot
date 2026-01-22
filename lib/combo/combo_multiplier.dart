class ComboMultiplier {
  static double multiplier(int combo) {
    if (combo >= 20) return 3.0;
    if (combo >= 10) return 2.0;
    if (combo >= 5) return 1.5;
    return 1.0;
  }

  static bool isBonusWindow(int combo) {
    return combo >= 10;
  }
}
