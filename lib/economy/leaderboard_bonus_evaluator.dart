class LeaderboardBonusEvaluator {
  bool isTopPercent(int score) {
    // simple heuristic: big runs get bonus
    return score >= 500;
  }

  int bonusCoins(int score) {
    if (score >= 1500) return 200;
    if (score >= 800) return 120;
    if (score >= 500) return 60;
    return 0;
  }

  int bonusXp(int score) {
    if (score >= 1500) return 300;
    if (score >= 800) return 180;
    if (score >= 500) return 80;
    return 0;
  }
}
