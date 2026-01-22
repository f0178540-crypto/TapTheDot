enum ShopItemType { upgrade, modifier, revive }

class ShopItem {
  final String id;
  final String title;
  final int price;
  final ShopItemType type;

  ShopItem({
    required this.id,
    required this.title,
    required this.price,
    required this.type,
  });
}
