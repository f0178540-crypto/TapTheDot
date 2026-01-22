import 'package:shared_preferences/shared_preferences.dart';
import 'achievements.dart';
import 'missions.dart';

class _AchievementEvent {
  final AchievementId id;
  final int rewardCoins;
  _AchievementEvent(this.id, this.rewardCoins);
}

class MetaTracker {
  static SharedPreferences? _prefs;

  static final List<_AchievementEvent> _achievementQueue = [];

  static DailyMission? _todayMission;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _todayMission = await Missions.getOrCreateToday(_prefs!);
  }

  // ===== ACHIEVEMENT EVENT CONSUME API (ZA UI) =====
  static bool consumeAchievementEvent(
      void Function(AchievementId id, int rewardCoins) cb) {
    if (_achievementQueue.isEmpty) return false;
    final e = _achievementQueue.removeAt(0);
    cb(e.id, e.rewardCoins);
    return true;
  }

  // ===== INTERNAL UNLOCK WRAPPER =====
  static Future<void> _tryUnlock(AchievementId id) async {
    if (_prefs == null) return;

    final unlocked = await Achievements.unlock(_prefs!, id);
    if (!unlocked) return;

    final ach = Achievements.all.firstWhere((a) => a.id == id);
    _achievementQueue.add(_AchievementEvent(id, ach.rewardCoins));
  }

  // =====================
  // GAMEPLAY HOOKS
  // =====================

  static void onHit() async {
    await _updateMission(MissionType.hitCount, 1);
    _tryUnlock(AchievementId.firstHit);
  }

  static void onMiss() {
    // miss ne utiče na daily missions
  }

  static void onPerfect() async {
    await _updateMission(MissionType.perfectCount, 1);
    _tryUnlock(AchievementId.perfect3);
  }

  static void onRiskKill() async {
    await _updateMission(MissionType.riskKills, 1);
    _tryUnlock(AchievementId.riskSlayer5);
  }

  static void onCombo(int chain) {
    if (chain >= 5) _tryUnlock(AchievementId.combo5);
    if (chain >= 10) _tryUnlock(AchievementId.combo10);
  }

  static void onLevelUp(int level) async {
    if (level >= 10) _tryUnlock(AchievementId.reachLevel10);
    await _updateMission(MissionType.reachLevel, level);
  }

  static void onRunEnd() {
    // trenutno nema daily mission vezanu za end run
  }

  // =====================
  // DAILY MISSION UPDATE
  // =====================

  static Future<void> _updateMission(MissionType type, int delta) async {
    if (_prefs == null) return;

    _todayMission ??= await Missions.getOrCreateToday(_prefs!);

    if (_todayMission!.type != type) return;

    if (Missions.isClaimed(_prefs!)) return;

    await Missions.addProgress(_prefs!, delta);
  }
}
