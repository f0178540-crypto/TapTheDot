enum UpgradeId {
  extraTimeWindow,
  reviveDiscount,
  scoreBoost,
  startingStreak,
}

class UpgradeNode {
  final UpgradeId id;
  final String name;
  final String description;
  final int maxLevel;
  final List<int> costs;

  const UpgradeNode({
    required this.id,
    required this.name,
    required this.description,
    required this.maxLevel,
    required this.costs,
  });
}

class UpgradeTree {
  static const List<UpgradeNode> nodes = [
    UpgradeNode(
      id: UpgradeId.extraTimeWindow,
      name: 'Perfect Window',
      description: 'Makes perfect window slightly larger.',
      maxLevel: 4,
      costs: [100, 200, 400, 800],
    ),
    UpgradeNode(
      id: UpgradeId.reviveDiscount,
      name: 'Revive Discount',
      description: 'Reduces revive cost.',
      maxLevel: 3,
      costs: [120, 240, 500],
    ),
    UpgradeNode(
      id: UpgradeId.scoreBoost,
      name: 'Score Boost',
      description: 'Adds flat score bonus per hit.',
      maxLevel: 5,
      costs: [60, 120, 200, 320, 500],
    ),
    UpgradeNode(
      id: UpgradeId.startingStreak,
      name: 'Starting Streak',
      description: 'Start runs with bonus streak.',
      maxLevel: 3,
      costs: [150, 300, 600],
    ),
  ];
}
