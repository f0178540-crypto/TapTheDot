enum BuildPathType {
  balanced,
  riskMaster,
  bossHunter,
  speedRunner,
}

class BuildPath {
  final BuildPathType type;
  final String name;

  final double scoreBonus;
  final double chaosBonus;
  final double bossBonus;
  final double speedBonus;

  const BuildPath({
    required this.type,
    required this.name,
    this.scoreBonus = 0,
    this.chaosBonus = 0,
    this.bossBonus = 0,
    this.speedBonus = 0,
  });
}
