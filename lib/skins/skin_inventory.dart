import 'package:shared_preferences/shared_preferences.dart';

class SkinInventory {
  static const _ownedKey = 'owned_skins';
  static const _activeKey = 'active_skin';

  Future<List<String>> owned() async {
    final p = await SharedPreferences.getInstance();
    return p.getStringList(_ownedKey) ?? ['default'];
  }

  Future<void> add(String id) async {
    final p = await SharedPreferences.getInstance();
    final list = await owned();
    if (!list.contains(id)) list.add(id);
    await p.setStringList(_ownedKey, list);
  }

  Future<String> active() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_activeKey) ?? 'default';
  }

  Future<void> setActive(String id) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_activeKey, id);
  }
}
