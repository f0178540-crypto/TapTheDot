import 'package:shared_preferences/shared_preferences.dart';
import 'daily_reward_calendar.dart';

class DailyRewardManager {
  static const _dayKey = 'daily_reward_day';
  static const _lastClaimKey = 'daily_reward_last';

  Future<int> getDayIndex() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_dayKey) ?? 0;
  }

  Future<bool> canClaim() async {
    final p = await SharedPreferences.getInstance();
    final last = p.getInt(_lastClaimKey);
    if (last == null) return true;

    final lastDate = DateTime.fromMillisecondsSinceEpoch(last);
    final now = DateTime.now();
    return now.difference(lastDate).inHours >= 20;
  }

  Future<int> claim() async {
    final p = await SharedPreferences.getInstance();
    int day = p.getInt(_dayKey) ?? 0;

    final reward = DailyRewardCalendar.rewardForDay(day);

    day = (day + 1) % 7;

    await p.setInt(_dayKey, day);
    await p.setInt(_lastClaimKey, DateTime.now().millisecondsSinceEpoch);

    return reward;
  }
}
