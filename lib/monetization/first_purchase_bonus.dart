class FirstPurchaseBonus {
  bool active = true;

  double rewardMultiplier() => active ? 2.0 : 1.0;

  void consume() {
    active = false;
  }
}
