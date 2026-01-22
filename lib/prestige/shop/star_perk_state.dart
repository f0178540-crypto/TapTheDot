import 'package:shared_preferences/shared_preferences.dart';
import 'star_perks.dart';

class StarPerkState {
  static const _key = 'star_perks';

  final Set<StarPerkType> unlocked = {};

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    unlocked.clear();
    for (final r in raw) {
      unlocked.add(StarPerkType.values.firstWhere((e) => e.name == r));
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _key, unlocked.map((e) => e.name).toList());
  }

  bool has(StarPerkType type) => unlocked.contains(type);

  Future<void> unlock(StarPerkType type) async {
    unlocked.add(type);
    await save();
  }
}
