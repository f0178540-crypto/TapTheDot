enum DailyQuestType {
  reachScore,
  hitCombo,
  defeatBoss,
}

class DailyQuest {
  final DailyQuestType type;
  final int target;
  int progress = 0;
  bool claimed = false;

  DailyQuest(this.type, this.target);

  bool get completed => progress >= target;

  void add(int v) {
    if (!completed) {
      progress += v;
      if (progress > target) progress = target;
    }
  }
}
