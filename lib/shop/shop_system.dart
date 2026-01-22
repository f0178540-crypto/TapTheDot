import '../economy/soft_currency.dart';
import 'shop_item.dart';

class ShopSystem {
  final SoftCurrency wallet;

  ShopSystem(this.wallet);

  bool buy(ShopItem item) {
    return wallet.spend(item.price);
  }

  List<ShopItem> defaultItems() {
    return [
      ShopItem(
        id: 'revive_1',
        title: 'Instant Revive',
        price: 50,
        type: ShopItemType.revive,
      ),
      ShopItem(
        id: 'upgrade_score',
        title: 'Score Boost',
        price: 120,
        type: ShopItemType.upgrade,
      ),
      ShopItem(
        id: 'modifier_combo',
        title: 'Combo Booster',
        price: 150,
        type: ShopItemType.modifier,
      ),
    ];
  }
}
