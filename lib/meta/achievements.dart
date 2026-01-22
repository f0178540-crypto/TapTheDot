import 'package:shared_preferences/shared_preferences.dart';

enum AchievementId {
  firstHit,
  combo5,
  combo10,
  perfect3,
  riskSlayer5,
  reachLevel10,
}

class Achievement {
  final AchievementId id;
  final String key;
  final int rewardCoins;

  const Achievement(this.id, this.key, this.rewardCoins);
}

class Achievements {
  static const List<Achievement> all = [
    Achievement(AchievementId.firstHit, 'ach_first_hit', 10),
    Achievement(AchievementId.combo5, 'ach_combo_5', 15),
    Achievement(AchievementId.combo10, 'ach_combo_10', 25),
    Achievement(AchievementId.perfect3, 'ach_perfect_3', 20),
    Achievement(AchievementId.riskSlayer5, 'ach_risk_5', 30),
    Achievement(AchievementId.reachLevel10, 'ach_lvl_10', 25),
  ];

  static Future<bool> isUnlocked(
      SharedPreferences prefs, AchievementId id) async {
    final ach = all.firstWhere((a) => a.id == id);
    return prefs.getBool(ach.key) ?? false;
  }

  static Future<bool> unlock(
      SharedPreferences prefs, AchievementId id) async {
    final ach = all.firstWhere((a) => a.id == id);
    final already = prefs.getBool(ach.key) ?? false;
    if (already) return false;
    await prefs.setBool(ach.key, true);
    return true;
  }
}
