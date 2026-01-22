import 'package:flutter/material.dart';
import '../../economy/iap_manager.dart';
import '../../economy/store_manager.dart';
import '../../config/product_ids.dart';
import 'shop_item_card.dart';

class StoreScreen extends StatelessWidget {
  final IapManager iap;
  final StoreManager store;

  const StoreScreen({super.key, required this.iap, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store')),
      body: ListView(
        children: [
          ShopItemCard(
            title: 'Remove Ads PRO',
            price: '€2.99',
            onBuy: () => iap.buy(ProductIds.removeAds),
          ),
          ShopItemCard(
            title: 'Starter Pack',
            price: '€0.99',
            onBuy: () => iap.buy(ProductIds.starterPack),
          ),
          ShopItemCard(
            title: '500 Coins',
            price: '€1.99',
            onBuy: () => iap.buy(ProductIds.coinPackSmall),
          ),
        ],
      ),
    );
  }
}
