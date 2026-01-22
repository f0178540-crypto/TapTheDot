import 'package:flutter/material.dart';
import '../shop_system.dart';
import '../shop_item.dart';

typedef BuyCallback = void Function(ShopItem item);
typedef CloseCallback = void Function();

class ShopOverlay extends StatelessWidget {
  final ShopSystem shop;
  final int coins;
  final BuyCallback onBuy;
  final CloseCallback onClose;

  const ShopOverlay({
    super.key,
    required this.shop,
    required this.coins,
    required this.onBuy,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final items = shop.defaultItems();

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('SHOP',
                  style: TextStyle(color: Colors.white, fontSize: 26)),
              const SizedBox(height: 10),
              Text('Coins: $coins',
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              for (final item in items)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    onPressed: () => onBuy(item),
                    child: SizedBox(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.title),
                          Text('${item.price}c'),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              TextButton(onPressed: onClose, child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }
}
