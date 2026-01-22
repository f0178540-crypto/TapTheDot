import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'challenge.dart';

class ChallengeManager {
  final List<Challenge> challenges;

  ChallengeManager(this.challenges);

  static Future<ChallengeManager> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('challenges');

    if (raw == null) return ChallengeManager([]);

    final decoded = jsonDecode(raw) as List<dynamic>;
    return ChallengeManager(
      decoded.map((e) => Challenge.fromJson(e)).toList(),
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = challenges.map((c) => c.toJson()).toList();
    prefs.setString('challenges', jsonEncode(list));
  }

  Challenge createChallenge({
    required String modeId,
    required int score,
  }) {
    final code = _generateCode();
    final challenge = Challenge(
      code: code,
      modeId: modeId,
      targetScore: score,
      createdAt: DateTime.now(),
    );

    challenges.add(challenge);
    return challenge;
  }

  Challenge? findByCode(String code) {
    for (final c in challenges) {
      if (c.code.toUpperCase() == code.toUpperCase()) return c;
    }
    return null;
  }

  String _generateCode() {
    const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    final rng = Random();
    return List.generate(6, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}
