import 'package:shared_preferences/shared_preferences.dart';

class ScoreStorage {
  static const _bestKey = 'best_score';

  Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_bestKey) ?? 0;
  }

  Future<void> saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final best = prefs.getInt(_bestKey) ?? 0;
    if (score > best) {
      await prefs.setInt(_bestKey, score);
    }
  }
}
