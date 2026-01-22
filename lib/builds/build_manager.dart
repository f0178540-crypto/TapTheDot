import 'build_path.dart';

class BuildManager {
  BuildPath active = defaultBuild;

  static const defaultBuild = BuildPath(
    type: BuildPathType.balanced,
    name: 'Balanced',
  );

  static const List<BuildPath> allBuilds = [
    defaultBuild,
    BuildPath(
      type: BuildPathType.riskMaster,
      name: 'Risk Master',
      scoreBonus: 0.10,
      chaosBonus: 0.15,
    ),
    BuildPath(
      type: BuildPathType.bossHunter,
      name: 'Boss Hunter',
      bossBonus: 0.25,
      scoreBonus: 0.05,
    ),
    BuildPath(
      type: BuildPathType.speedRunner,
      name: 'Speed Runner',
      speedBonus: 0.20,
      chaosBonus: 0.10,
    ),
  ];

  void setBuild(BuildPath path) {
    active = path;
  }
}
