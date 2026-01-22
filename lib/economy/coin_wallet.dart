import 'package:shared_preferences/shared_preferences.dart';

class CoinWallet {
  static const _key = 'coins';

  Future<int> getCoins() async {
    final p = await SharedPreferences.getInstance();
    return p.getInt(_key) ?? 0;
  }

  Future<void> add(int v) async {
    final p = await SharedPreferences.getInstance();
    final c = p.getInt(_key) ?? 0;
    await p.setInt(_key, c + v);
  }

  Future<bool> spend(int v) async {
    final p = await SharedPreferences.getInstance();
    final c = p.getInt(_key) ?? 0;
    if (c < v) return false;
    await p.setInt(_key, c - v);
    return true;
  }
}
