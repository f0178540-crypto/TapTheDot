import 'event_quest.dart';

class EventQuestManager {
  final List<EventQuest> _quests = [];

  List<EventQuest> get quests => _quests;

  void setQuests(List<EventQuest> q) {
    _quests
      ..clear()
      ..addAll(q);
  }

  void clear() => _quests.clear();

  void onScore(int v) {
    for (final q in _quests) {
      if (q.type == EventQuestType.score) q.add(v);
    }
  }

  void onCombo(int v) {
    for (final q in _quests) {
      if (q.type == EventQuestType.combo) q.add(v);
    }
  }

  void onBoss() {
    for (final q in _quests) {
      if (q.type == EventQuestType.bosses) q.add(1);
    }
  }
}
