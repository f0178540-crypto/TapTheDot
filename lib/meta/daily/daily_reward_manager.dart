import 'package:shared_preferences/shared_preferences.dart';
import 'daily_reward.dart';

class DailyRewardManager {
  static const _lastClaimKey = 'daily_last_claim';
  static const _streakKey = 'daily_streak';

  final List<DailyReward> rewards = [
    DailyReward(day: 1, coins: 50),
    DailyReward(day: 2, coins: 75),
    DailyReward(day: 3, coins: 100),
    DailyReward(day: 4, coins: 150),
    DailyReward(day: 5, coins: 200),
    DailyReward(day: 6, coins: 300),
    DailyReward(day: 7, coins: 500, boost: 'double_score'),
  ];

  int streak = 0;
  DateTime? lastClaim;

  static Future<DailyRewardManager> load() async {
    final m = DailyRewardManager();
    final p = await SharedPreferences.getInstance();

    final last = p.getInt(_lastClaimKey);
    if (last != null) {
      m.lastClaim = DateTime.fromMillisecondsSinceEpoch(last);
    }
    m.streak = p.getInt(_streakKey) ?? 0;

    return m;
  }

  bool canClaim() {
    if (lastClaim == null) return true;
    final now = DateTime.now();
    return now.difference(lastClaim!).inHours >= 20;
  }

  DailyReward currentReward() {
    final idx = (streak % rewards.length);
    return rewards[idx];
  }

  Future<DailyReward?> claim() async {
    if (!canClaim()) return null;

    final now = DateTime.now();

    if (lastClaim != null &&
        now.difference(lastClaim!).inHours > 48) {
      streak = 0;
    }

    final reward = currentReward();
    streak++;

    final p = await SharedPreferences.getInstance();
    await p.setInt(_lastClaimKey, now.millisecondsSinceEpoch);
    await p.setInt(_streakKey, streak);

    lastClaim = now;

    return reward;
  }
}
