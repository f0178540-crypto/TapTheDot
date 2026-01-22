import '../boosts/boost.dart';

enum ShopItemType {
  coins,
  boost,
  bundle,
}

class ShopItem {
  final String id;
  final String title;
  final String description;
  final ShopItemType type;

  final int coinAmount;
  final BoostType? boostType;

  final int priceCoins; // soft currency price

  ShopItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    this.coinAmount = 0,
    this.boostType,
    required this.priceCoins,
  });
}
