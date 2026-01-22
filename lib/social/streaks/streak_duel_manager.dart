class StreakDuelManager {
  int currentStreak = 0;
  int bestStreak = 0;

  void recordWin() {
    currentStreak++;
    if (currentStreak > bestStreak) bestStreak = currentStreak;
  }

  void recordLoss() {
    currentStreak = 0;
  }
}
