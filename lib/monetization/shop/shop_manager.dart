import '../boosts/boost_manager.dart';
import '../boosts/boost.dart';
import 'shop_item.dart';

class ShopManager {
  final List<ShopItem> items = [
    // ===== COIN PACKS =====
    ShopItem(
      id: "coins_small",
      title: "Coin Pack S",
      description: "+100 coins",
      type: ShopItemType.coins,
      coinAmount: 100,
      priceCoins: 0, // free via ads / events
    ),
    ShopItem(
      id: "coins_medium",
      title: "Coin Pack M",
      description: "+500 coins",
      type: ShopItemType.coins,
      coinAmount: 500,
      priceCoins: 200,
    ),
    ShopItem(
      id: "coins_large",
      title: "Coin Pack L",
      description: "+2000 coins",
      type: ShopItemType.coins,
      coinAmount: 2000,
      priceCoins: 800,
    ),

    // ===== BOOSTS =====
    ShopItem(
      id: "boost_time",
      title: "Time Boost",
      description: "+10s next round",
      type: ShopItemType.boost,
      boostType: BoostType.extraTime,
      priceCoins: 50,
    ),
    ShopItem(
      id: "boost_score",
      title: "Double Score",
      description: "x2 score next round",
      type: ShopItemType.boost,
      boostType: BoostType.doubleScore,
      priceCoins: 80,
    ),
    ShopItem(
      id: "boost_revive",
      title: "Revive Token",
      description: "Survive one hit",
      type: ShopItemType.boost,
      boostType: BoostType.revive,
      priceCoins: 120,
    ),

    // ===== BUNDLE =====
    ShopItem(
      id: "starter_bundle",
      title: "Starter Bundle",
      description: "500 coins + Time Boost",
      type: ShopItemType.bundle,
      coinAmount: 500,
      boostType: BoostType.extraTime,
      priceCoins: 300,
    ),
  ];

  bool canBuy(ShopItem item, int coins) {
    return coins >= item.priceCoins;
  }

  void applyPurchase({
    required ShopItem item,
    required BoostManager boostManager,
    required void Function(int deltaCoins) addCoins,
  }) {
    if (item.type == ShopItemType.coins) {
      addCoins(item.coinAmount);
    }

    if (item.type == ShopItemType.boost && item.boostType != null) {
      boostManager.add(item.boostType!);
    }

    if (item.type == ShopItemType.bundle) {
      if (item.coinAmount > 0) addCoins(item.coinAmount);
      if (item.boostType != null) boostManager.add(item.boostType!);
    }
  }
}
