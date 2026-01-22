import 'package:shared_preferences/shared_preferences.dart';

class QuestSystem {
  static const _hitsKey = 'q_hits';
  static const _perfectKey = 'q_perfect';

  Future<void> addHit() async {
    final p = await SharedPreferences.getInstance();
    p.setInt(_hitsKey, (p.getInt(_hitsKey) ?? 0) + 1);
  }

  Future<void> addPerfect() async {
    final p = await SharedPreferences.getInstance();
    p.setInt(_perfectKey, (p.getInt(_perfectKey) ?? 0) + 1);
  }

  Future<Map<String, int>> getStatus() async {
    final p = await SharedPreferences.getInstance();
    return {
      'hits': p.getInt(_hitsKey) ?? 0,
      'perfect': p.getInt(_perfectKey) ?? 0,
    };
  }

  Future<void> resetDaily() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_hitsKey, 0);
    await p.setInt(_perfectKey, 0);
  }
}
