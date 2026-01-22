import 'package:shared_preferences/shared_preferences.dart';

class XpSystem {
  static const _xpKey = 'xp';
  static const _lvlKey = 'level';

  Future<int> getXp() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_xpKey) ?? 0;
  }

  Future<int> getLevel() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_lvlKey) ?? 1;
  }

  int xpForNextLevel(int lvl) => 100 + (lvl * 40);

  Future<bool> addXp(int v) async {
    final p = await SharedPreferences.getInstance();
    int xp = p.getInt(_xpKey) ?? 0;
    int lvl = p.getInt(_lvlKey) ?? 1;

    xp += v;

    final need = xpForNextLevel(lvl);
    bool leveledUp = false;

    if (xp >= need) {
      xp -= need;
      lvl++;
      leveledUp = true;
    }

    await p.setInt(_xpKey, xp);
    await p.setInt(_lvlKey, lvl);
    return leveledUp;
  }
}
