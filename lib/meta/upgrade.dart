enum UpgradeId {
  perfectWindow,
  reviveDiscount,
  startingStreak,
}

class UpgradeDefinition {
  final UpgradeId id;
  final String title;
  final String description;
  final List<int> costs;

  const UpgradeDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.costs,
  });

  int maxLevel() => costs.length;
}
