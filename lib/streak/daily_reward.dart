class DailyReward {
  final int day;
  final int coins;
  final bool boost;

  const DailyReward({
    required this.day,
    required this.coins,
    this.boost = false,
  });
}
