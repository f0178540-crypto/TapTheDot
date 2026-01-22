import 'upgrade.dart';

class UpgradeTree {
  static final List<UpgradeDefinition> upgrades = [
    UpgradeDefinition(
      id: UpgradeId.perfectWindow,
      title: 'Focus Training',
      description: 'Slightly increases perfect hit window.',
      costs: [50, 150, 400, 900],
    ),
    UpgradeDefinition(
      id: UpgradeId.reviveDiscount,
      title: 'Second Chance',
      description: 'Reduces revive coin cost.',
      costs: [100, 300, 700],
    ),
    UpgradeDefinition(
      id: UpgradeId.startingStreak,
      title: 'Hot Start',
      description: 'Start runs with combo already active.',
      costs: [200, 600],
    ),
  ];

  static UpgradeDefinition def(UpgradeId id) =>
      upgrades.firstWhere((u) => u.id == id);
}
