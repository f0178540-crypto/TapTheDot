class EventReward {
  final String id;
  final int softCurrency;
  final bool cosmeticUnlock;

  EventReward({
    required this.id,
    required this.softCurrency,
    this.cosmeticUnlock = false,
  });
}
