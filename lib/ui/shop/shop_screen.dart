import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../monetization/shop/shop_manager.dart';
import '../../monetization/shop/shop_item.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = ShopManager();

    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("Coins: ${ctrl.coins}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 12),
            ...shop.items.map((item) {
              final canBuy = shop.canBuy(item, ctrl.coins);

              return Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  trailing: ElevatedButton(
                    onPressed: canBuy
                        ? () {
                            ctrl.coins -= item.priceCoins;
                            shop.applyPurchase(
                              item: item,
                              boostManager: ctrl.boostManager,
                              addCoins: ctrl.addCoins,
                            );
                            ctrl.notifyListeners();
                          }
                        : null,
                    child: Text(item.priceCoins == 0
                        ? "FREE"
                        : "${item.priceCoins}"),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Text("Watch Ad For Boost"),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ctrl.watchAdForBoost(
                  shop.items
                      .firstWhere((i) => i.id == "boost_time")
                      .boostType!,
                );
              },
              child: const Text("+10s Boost"),
            ),
            ElevatedButton(
              onPressed: () {
                ctrl.watchAdForBoost(
                  shop.items
                      .firstWhere((i) => i.id == "boost_score")
                      .boostType!,
                );
              },
              child: const Text("x2 Score Boost"),
            ),
            ElevatedButton(
              onPressed: () {
                ctrl.watchAdForBoost(
                  shop.items
                      .firstWhere((i) => i.id == "boost_revive")
                      .boostType!,
                );
              },
              child: const Text("Revive Token"),
            ),
          ],
        );
      },
    );
  }
}
