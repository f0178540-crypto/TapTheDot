class StarterPack {
  bool purchased = false;

  bool get available => !purchased;

  void markPurchased() {
    purchased = true;
  }
}
