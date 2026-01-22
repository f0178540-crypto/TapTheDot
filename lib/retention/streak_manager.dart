import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  static const _lastDayKey = 'last_play_day';
  static const _streakKey = 'streak';

  Future<int> updateStreak() async {
    final p = await SharedPreferences.getInstance();
    final today = DateTime.now().day;

    final last = p.getInt(_lastDayKey);
    int streak = p.getInt(_streakKey) ?? 0;

    if (last == today - 1) {
      streak++;
    } else if (last != today) {
      streak = 1;
    }

    await p.setInt(_lastDayKey, today);
    await p.setInt(_streakKey, streak);
    return streak;
  }
}
