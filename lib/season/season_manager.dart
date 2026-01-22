import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'season.dart';

class SeasonManager {
  final Season season;

  int xp = 0;
  int tier = 1;

  SeasonManager(this.season);

  static SeasonManager createDefault() {
    return SeasonManager(
      Season(
        id: "s1",
        name: "Season 1",
        totalXpForTier: 100,
        maxTier: 30,
      ),
    );
  }

  void addXp(int amount) {
    xp += amount;
    while (xp >= season.totalXpForTier && tier < season.maxTier) {
      xp -= season.totalXpForTier;
      tier += 1;
    }
  }

  Map<String, dynamic> toJson() => {
        'xp': xp,
        'tier': tier,
      };

  static SeasonManager fromJson(Season season, Map<String, dynamic> json) {
    final sm = SeasonManager(season);
    sm.xp = json['xp'] ?? 0;
    sm.tier = json['tier'] ?? 1;
    return sm;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('season', jsonEncode(toJson()));
  }

  static Future<SeasonManager> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('season');

    final season = createDefault().season;

    if (raw == null) return createDefault();

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return fromJson(season, decoded);
  }
}
