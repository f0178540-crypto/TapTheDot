import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

enum MissionType {
  hitCount,
  perfectCount,
  riskKills,
  reachLevel,
}

class DailyMission {
  final MissionType type;
  final int target;
  final int rewardCoins;

  const DailyMission(this.type, this.target, this.rewardCoins);

  String get key => 'mission_${type.name}_$target';
}

class Missions {
  static const String _dayKey = 'missions_day';
  static const String _typeKey = 'missions_type';
  static const String _targetKey = 'missions_target';
  static const String _rewardKey = 'missions_reward';
  static const String _progressKey = 'missions_progress';
  static const String _claimedKey = 'missions_claimed';

  static Future<DailyMission> getOrCreateToday(SharedPreferences prefs) async {
    final today = _dayStamp();
    final savedDay = prefs.getString(_dayKey);

    if (savedDay == today) {
      final type =
          MissionType.values[prefs.getInt(_typeKey) ?? 0];
      final target = prefs.getInt(_targetKey) ?? 10;
      final reward = prefs.getInt(_rewardKey) ?? 10;
      return DailyMission(type, target, reward);
    }

    final rnd = Random();
    final type = MissionType.values[rnd.nextInt(MissionType.values.length)];

    int target;
    int reward;

    switch (type) {
      case MissionType.hitCount:
        target = 30;
        reward = 20;
        break;
      case MissionType.perfectCount:
        target = 10;
        reward = 25;
        break;
      case MissionType.riskKills:
        target = 3;
        reward = 30;
        break;
      case MissionType.reachLevel:
        target = 7;
        reward = 25;
        break;
    }

    await prefs.setString(_dayKey, today);
    await prefs.setInt(_typeKey, type.index);
    await prefs.setInt(_targetKey, target);
    await prefs.setInt(_rewardKey, reward);
    await prefs.setInt(_progressKey, 0);
    await prefs.setBool(_claimedKey, false);

    return DailyMission(type, target, reward);
  }

  static int getProgress(SharedPreferences prefs) {
    return prefs.getInt(_progressKey) ?? 0;
  }

  static bool isClaimed(SharedPreferences prefs) {
    return prefs.getBool(_claimedKey) ?? false;
  }

  static Future<void> addProgress(SharedPreferences prefs, int delta) async {
    final cur = prefs.getInt(_progressKey) ?? 0;
    await prefs.setInt(_progressKey, cur + delta);
  }

  static Future<void> markClaimed(SharedPreferences prefs) async {
    await prefs.setBool(_claimedKey, true);
  }

  static String _dayStamp() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
