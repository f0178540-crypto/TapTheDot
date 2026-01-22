enum EventQuestType { score, combo, bosses }

class EventQuest {
  final String id;
  final EventQuestType type;
  final int target;
  int progress = 0;
  bool completed = false;

  EventQuest({
    required this.id,
    required this.type,
    required this.target,
  });

  void add(int v) {
    if (completed) return;
    progress += v;
    if (progress >= target) completed = true;
  }
}
