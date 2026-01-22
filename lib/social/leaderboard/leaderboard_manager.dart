import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'leaderboard_entry.dart';

class LeaderboardManager {
  final List<LeaderboardEntry> entries;

  LeaderboardManager(this.entries);

  static Future<LeaderboardManager> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('leaderboard');

    if (raw == null) return LeaderboardManager([]);

    final decoded = jsonDecode(raw) as List<dynamic>;
    return LeaderboardManager(
      decoded.map((e) => LeaderboardEntry.fromJson(e)).toList(),
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = entries.map((e) => e.toJson()).toList();
    prefs.setString('leaderboard', jsonEncode(list));
  }

  void submit(LeaderboardEntry entry) {
    entries.add(entry);

    entries.sort((a, b) => b.score.compareTo(a.score));

    if (entries.length > 100) {
      entries.removeRange(100, entries.length);
    }
  }

  List<LeaderboardEntry> topByMode(String modeId, {int limit = 20}) {
    return entries
        .where((e) => e.modeId == modeId)
        .take(limit)
        .toList();
  }

  int? bestScore(String modeId) {
    for (final e in entries) {
      if (e.modeId == modeId) return e.score;
    }
    return null;
  }
}
