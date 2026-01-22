class StreakBonus {
  static int coinBonus(int streak) {
    if (streak >= 14) return 100;
    if (streak >= 7) return 50;
    if (streak >= 3) return 20;
    return 0;
  }

  static int xpBonus(int streak) {
    if (streak >= 14) return 40;
    if (streak >= 7) return 20;
    if (streak >= 3) return 10;
    return 0;
  }
}
