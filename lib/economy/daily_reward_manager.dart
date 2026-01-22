import 'package:shared_preferences/shared_preferences.dart';

class DailyRewardManager {
  static const _key = 'last_daily_claim';

  Future<bool> canClaimToday() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString(_key);
    final today = _todayKey();
    return last != today;
  }

  Future<void> markClaimed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, _todayKey());
  }

  String _todayKey() {
    final now = DateTime.now().toUtc();
    return '${now.year}-${now.month}-${now.day}';
  }
}
