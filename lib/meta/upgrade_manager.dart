import 'package:shared_preferences/shared_preferences.dart';

import 'upgrade.dart';
import 'upgrade_tree.dart';

class UpgradeManager {
  static final UpgradeManager instance = UpgradeManager._internal();
  UpgradeManager._internal();

  static const _prefsKey = 'upgrade_levels';

  final Map<UpgradeId, int> _levels = {};

  bool _loaded = false;

  // ===== LOAD / SAVE =====

  Future<void> load() async {
    if (_loaded) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];

    _levels.clear();

    for (final entry in raw) {
      final parts = entry.split(':');
      if (parts.length != 2) continue;

      final id = UpgradeId.values.firstWhere(
        (e) => e.name == parts[0],
        orElse: () => UpgradeId.perfectWindow,
      );

      final lvl = int.tryParse(parts[1]) ?? 0;
      _levels[id] = lvl;
    }

    _loaded = true;
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    final raw = _levels.entries
        .map((e) => '${e.key.name}:${e.value}')
        .toList();

    await prefs.setStringList(_prefsKey, raw);
  }

  // ===== READ API =====

  int level(UpgradeId id) => _levels[id] ?? 0;

  bool isMaxed(UpgradeId id) {
    final def = UpgradeTree.def(id);
    return level(id) >= def.maxLevel();
  }

  int costForNext(UpgradeId id) {
    final def = UpgradeTree.def(id);
    final lvl = level(id);
    if (lvl >= def.maxLevel()) return -1;
    return def.costs[lvl];
  }

  // ===== WRITE API =====

  Future<void> increaseLevel(UpgradeId id) async {
    final def = UpgradeTree.def(id);
    final lvl = level(id);
    if (lvl >= def.maxLevel()) return;

    _levels[id] = lvl + 1;
    await _save();
  }
}
