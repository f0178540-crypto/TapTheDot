class IapProduct {
  final String id;
  final String title;
  final int coins;

  IapProduct(this.id, this.title, this.coins);
}

class IapCatalog {
  static final products = [
    IapProduct('coins_small', 'Small Coin Pack', 300),
    IapProduct('coins_medium', 'Medium Coin Pack', 900),
    IapProduct('coins_large', 'Large Coin Pack', 2500),
  ];
}
