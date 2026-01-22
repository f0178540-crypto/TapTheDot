import 'package:flutter/material.dart';
import '../../skins/skin_manager.dart';
import '../../skins/skin_inventory.dart';
import '../../economy/coin_wallet.dart';

class SkinShopScreen extends StatefulWidget {
  const SkinShopScreen({super.key});

  @override
  State<SkinShopScreen> createState() => _SkinShopScreenState();
}

class _SkinShopScreenState extends State<SkinShopScreen> {
  final inventory = SkinInventory();
  final wallet = CoinWallet();

  List<String> owned = [];
  int coins = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    owned = await inventory.owned();
    coins = await wallet.getCoins();
    setState(() {});
  }

  Future<void> _buy(String id, int price) async {
    if (coins < price) return;
    await wallet.spend(price);
    await inventory.add(id);
    await inventory.setActive(id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skins')),
      body: ListView(
        children: SkinManager.skins.map((s) {
          final isOwned = owned.contains(s.id);
          return ListTile(
            leading: CircleAvatar(backgroundColor: Color(s.color)),
            title: Text(s.name),
            subtitle: Text(isOwned ? 'Owned' : '${s.price} coins'),
            trailing: ElevatedButton(
              onPressed: isOwned ? () => inventory.setActive(s.id) : () => _buy(s.id, s.price),
              child: Text(isOwned ? 'Use' : 'Buy'),
            ),
          );
        }).toList(),
      ),
    );
  }
}
