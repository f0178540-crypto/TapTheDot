import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'mission.dart';
import 'mission_type.dart';

class MissionManager {
  final List<Mission> missions;

  MissionManager(this.missions);

  static MissionManager createDefault() {
    return MissionManager([
      Mission(type: MissionType.hitTargets, targetValue: 50, rewardCoins: 100),
      Mission(type: MissionType.reachScore, targetValue: 20, rewardCoins: 120),
      Mission(type: MissionType.playRounds, targetValue: 3, rewardCoins: 80),
    ]);
  }

  void onHit() {
    for (final m in missions) {
      if (m.type == MissionType.hitTargets) m.add(1);
    }
  }

  void onScore(int score) {
    for (final m in missions) {
      if (m.type == MissionType.reachScore && score >= m.targetValue) {
        m.progress = m.targetValue;
      }
    }
  }

  void onRoundPlayed() {
    for (final m in missions) {
      if (m.type == MissionType.playRounds) m.add(1);
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = missions.map((m) => m.toJson()).toList();
    prefs.setString('missions', jsonEncode(list));
  }

  static Future<MissionManager> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('missions');

    final template = createDefault();

    if (raw == null) return template;

    final decoded = jsonDecode(raw) as List<dynamic>;

    final result = <Mission>[];

    for (int i = 0; i < template.missions.length; i++) {
      if (i < decoded.length) {
        result.add(Mission.fromJson(decoded[i], template.missions[i]));
      } else {
        result.add(template.missions[i]);
      }
    }

    return MissionManager(result);
  }
}
