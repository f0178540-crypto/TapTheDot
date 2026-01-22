import 'dart:math';
import 'daily_quest.dart';

class DailyQuestManager {
  DateTime? _lastReset;
  final List<DailyQuest> quests = [];

  void ensureToday() {
    final now = DateTime.now();
    if (_lastReset == null ||
        _lastReset!.day != now.day ||
        _lastReset!.month != now.month ||
        _lastReset!.year != now.year) {
      _generate();
      _lastReset = now;
    }
  }

  void _generate() {
    quests.clear();
    final rnd = Random();

    quests.add(DailyQuest(DailyQuestType.reachScore, 40 + rnd.nextInt(60)));
    quests.add(DailyQuest(DailyQuestType.hitCombo, 8 + rnd.nextInt(8)));
    quests.add(DailyQuest(DailyQuestType.defeatBoss, 1));
  }

  bool get allCompleted => quests.every((q) => q.completed);

  int claimRewards() {
    int reward = 0;
    for (final q in quests) {
      if (q.completed && !q.claimed) {
        q.claimed = true;
        reward += 80;
      }
    }
    return reward;
  }
}
