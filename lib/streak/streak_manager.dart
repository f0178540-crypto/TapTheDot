import 'package:shared_preferences/shared_preferences.dart';
import 'daily_reward.dart';

class StreakManager {
  static const _lastLoginKey = 'last_login_day';
  static const _streakKey = 'login_streak';

  int streak = 0;
  bool rewardAvailable = false;

  final rewards = const [
    DailyReward(day: 1, coins: 50),
    DailyReward(day: 2, coins: 75),
    DailyReward(day: 3, coins: 100, boost: true),
    DailyReward(day: 4, coins: 125),
    DailyReward(day: 5, coins: 150, boost: true),
    DailyReward(day: 6, coins: 200),
    DailyReward(day: 7, coins: 300, boost: true),
  ];

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDay = prefs.getInt(_lastLoginKey) ?? 0;
    final savedStreak = prefs.getInt(_streakKey) ?? 0;

    final today = _dayStamp();

    if (today == lastDay) {
      streak = savedStreak;
      rewardAvailable = false;
    } else if (today == lastDay + 1) {
      streak = savedStreak + 1;
      rewardAvailable = true;
    } else {
      streak = 1;
      rewardAvailable = true;
    }

    if (streak > rewards.length) streak = rewards.length;

    await prefs.setInt(_lastLoginKey, today);
    await prefs.setInt(_streakKey, streak);
  }

  DailyReward? claim() {
    if (!rewardAvailable) return null;
    rewardAvailable = false;
    return rewards[streak - 1];
  }

  int _dayStamp() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day)
        .millisecondsSinceEpoch ~/
        Duration.millisecondsPerDay;
  }
}
