import 'package:shared_preferences/shared_preferences.dart';

class SeasonProgress {
  static const _xpKey = 'season_xp';
  static const _lvlKey = 'season_lvl';

  Future<int> level() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_lvlKey) ?? 1;
  }

  Future<void> addXp(int v) async {
    final p = await SharedPreferences.getInstance();
    int xp = p.getInt(_xpKey) ?? 0;
    int lvl = p.getInt(_lvlKey) ?? 1;

    xp += v;
    if (xp >= 100) {
      xp -= 100;
      lvl++;
    }

    await p.setInt(_xpKey, xp);
    await p.setInt(_lvlKey, lvl);
  }
}
