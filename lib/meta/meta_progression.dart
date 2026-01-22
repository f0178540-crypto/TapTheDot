import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'player_profile.dart';

class MetaProgression {
  static const _key = 'player_profile';

  PlayerProfile profile = PlayerProfile();

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;

    final map = jsonDecode(raw) as Map<String, dynamic>;
    profile = PlayerProfile.fromJson(map);
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(profile.toJson());
    await prefs.setString(_key, raw);
  }
}
