import 'boost.dart';

class BoostManager {
  final Map<BoostType, Boost> _active = {};

  bool has(BoostType type) => _active.containsKey(type);

  void add(BoostType type) {
    _active[type] = Boost(type);
  }

  void consume(BoostType type) {
    _active[type]?.used = true;
  }

  bool canUse(BoostType type) {
    final b = _active[type];
    return b != null && !b.used;
  }

  void resetRound() {
    _active.clear();
  }

  /// EFFECT HELPERS

  int applyExtraTime(int baseMs) {
    if (canUse(BoostType.extraTime)) {
      consume(BoostType.extraTime);
      return baseMs + 10000;
    }
    return baseMs;
  }

  int applyScore(int baseScore) {
    if (canUse(BoostType.doubleScore)) {
      return baseScore * 2;
    }
    return baseScore;
  }

  bool tryRevive() {
    if (canUse(BoostType.revive)) {
      consume(BoostType.revive);
      return true;
    }
    return false;
  }
}
