import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DailyReward {
  static const _key = 'daily_reward_ts';

  bool canClaim = false;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getInt(_key);

    if (last == null) {
      canClaim = true;
      return;
    }

    final lastDate = DateTime.fromMillisecondsSinceEpoch(last);
    final now = DateTime.now();

    canClaim = now.difference(lastDate).inHours >= 24;
  }

  Future<void> claim() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, DateTime.now().millisecondsSinceEpoch);
    canClaim = false;
  }
}
