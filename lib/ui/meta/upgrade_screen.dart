import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../meta/upgrade_manager.dart';
import '../../meta/upgrade_tree.dart';
import '../../meta/upgrade.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  final mgr = UpgradeManager.instance;

  int _coins = 0;
  bool _loading = true;

  static const _coinsKey = 'player_coins';

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    await mgr.load();

    final prefs = await SharedPreferences.getInstance();
    final coins = prefs.getInt(_coinsKey) ?? 0;

    setState(() {
      _coins = coins;
      _loading = false;
    });
  }

  Future<void> _saveCoins(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_coinsKey, value);
  }

  Future<void> _buyUpgrade(UpgradeId id, int cost) async {
    if (_coins < cost) return;

    final newCoins = _coins - cost;
    await _saveCoins(newCoins);
    await mgr.increaseLevel(id);

    setState(() {
      _coins = newCoins;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Upgrades'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Coins: $_coins',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: UpgradeTree.upgrades.length,
              itemBuilder: (context, index) {
                final def = UpgradeTree.upgrades[index];
                final level = mgr.level(def.id);
                final isMaxed = mgr.isMaxed(def.id);
                final cost = mgr.costForNext(def.id);

                final canBuy = !isMaxed && _coins >= cost;

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        def.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        def.description,
                        style: TextStyle(color: Colors.grey.shade300),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Level: $level / ${def.maxLevel()}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          ElevatedButton(
                            onPressed: canBuy
                                ? () => _buyUpgrade(def.id, cost)
                                : null,
                            child: Text(isMaxed ? 'MAX' : 'Buy ($cost)'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
