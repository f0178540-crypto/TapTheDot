import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class DailyChallenge {
  static const _dayKey = 'daily_seed_day';
  static const _seedKey = 'daily_seed';

  Future<int> getSeed() async {
    final p = await SharedPreferences.getInstance();
    final today = DateTime.now().day;

    final savedDay = p.getInt(_dayKey);
    if (savedDay == today) {
      return p.getInt(_seedKey) ?? 1;
    }

    final seed = Random().nextInt(999999);
    await p.setInt(_dayKey, today);
    await p.setInt(_seedKey, seed);
    return seed;
  }
}
