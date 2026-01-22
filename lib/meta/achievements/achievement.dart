enum AchievementType {
  totalScore,
  maxCombo,
  bossesDefeated,
  dailyQuestsCompleted,
}

class Achievement {
  final AchievementType type;
  final int target;
  bool unlocked = false;

  Achievement(this.type, this.target);

  bool check(int value) {
    if (!unlocked && value >= target) {
      unlocked = true;
      return true;
    }
    return false;
  }
}
