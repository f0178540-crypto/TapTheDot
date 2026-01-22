import 'achievement.dart';

class AchievementManager {
  final List<Achievement> achievements = [
    Achievement(AchievementType.totalScore, 500),
    Achievement(AchievementType.totalScore, 2000),
    Achievement(AchievementType.maxCombo, 15),
    Achievement(AchievementType.bossesDefeated, 3),
    Achievement(AchievementType.dailyQuestsCompleted, 5),
  ];

  final List<Achievement> newlyUnlocked = [];

  void clearNew() => newlyUnlocked.clear();

  void check(AchievementType type, int value) {
    for (final a in achievements.where((x) => x.type == type)) {
      if (a.check(value)) {
        newlyUnlocked.add(a);
      }
    }
  }

  int get unlockedCount =>
      achievements.where((a) => a.unlocked).length;
}
