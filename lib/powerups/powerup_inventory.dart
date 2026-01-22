import 'package:shared_preferences/shared_preferences.dart';
import 'powerup_type.dart';

class PowerupInventory {
  static const _slowMoKey = 'pu_slowmo';
  static const _shieldKey = 'pu_shield';

  Future<int> get(PowerupType t) async {
    final p = await SharedPreferences.getInstance();
    switch (t) {
      case PowerupType.slowMo:
        return p.getInt(_slowMoKey) ?? 0;
      case PowerupType.shield:
        return p.getInt(_shieldKey) ?? 0;
    }
  }

  Future<void> add(PowerupType t, int v) async {
    final p = await SharedPreferences.getInstance();
    final c = await get(t);
    switch (t) {
      case PowerupType.slowMo:
        await p.setInt(_slowMoKey, c + v);
        break;
      case PowerupType.shield:
        await p.setInt(_shieldKey, c + v);
        break;
    }
  }

  Future<bool> use(PowerupType t) async {
    final p = await SharedPreferences.getInstance();
    final c = await get(t);
    if (c <= 0) return false;
    switch (t) {
      case PowerupType.slowMo:
        await p.setInt(_slowMoKey, c - 1);
        break;
      case PowerupType.shield:
        await p.setInt(_shieldKey, c - 1);
        break;
    }
    return true;
  }
}
