class SoftCurrency {
  int coins = 0;

  void add(int amount) {
    coins += amount;
  }

  bool spend(int amount) {
    if (coins < amount) return false;
    coins -= amount;
    return true;
  }

  Map<String, dynamic> toJson() => {'coins': coins};

  void fromJson(Map<String, dynamic> json) {
    coins = json['coins'] ?? 0;
  }
}
