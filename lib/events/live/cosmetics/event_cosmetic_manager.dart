import 'event_cosmetic.dart';

class EventCosmeticManager {
  final List<EventCosmetic> _available = [];
  final Set<String> _unlocked = {};

  List<EventCosmetic> get available => _available;
  bool isUnlocked(String id) => _unlocked.contains(id);

  void setForEvent(List<EventCosmetic> items) {
    _available
      ..clear()
      ..addAll(items);
  }

  void unlock(String id) {
    _unlocked.add(id);
  }

  void clear() {
    _available.clear();
  }
}
