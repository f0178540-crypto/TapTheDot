import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../monetization/iap/iap_manager.dart';
import '../../monetization/iap/iap_service.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        final mgr = ctrl.iapManager;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              "Premium Store",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _productTile(
              context,
              mgr,
              "coins_1000",
              "1,000 Coins",
            ),

            _productTile(
              context,
              mgr,
              "coins_5000",
              "5,000 Coins",
            ),

            _productTile(
              context,
              mgr,
              "starter_pack",
              "Starter Pack (Coins + Boosts)",
            ),

            _productTile(
              context,
              mgr,
              "season_pass_premium",
              "Premium Season Pass",
            ),

            const SizedBox(height: 24),
            const Text(
              "NOTE: Purchases work only when installed from Google Play (Internal Testing).",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        );
      },
    );
  }

  Widget _productTile(
    BuildContext context,
    IapManager mgr,
    String id,
    String title,
  ) {
    final product = mgr.get(id);

    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(product?.price ?? "Not available"),
        trailing: ElevatedButton(
          onPressed: product == null
              ? null
              : () {
                  IapService.buy(product);
                },
          child: const Text("Buy"),
        ),
      ),
    );
  }
}
