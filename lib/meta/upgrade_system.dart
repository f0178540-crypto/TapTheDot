import 'player_profile.dart';

enum UpgradeType { speed, size, score }

class UpgradeSystem {
  void applyUpgrade(PlayerProfile profile, UpgradeType type) {
    switch (type) {
      case UpgradeType.speed:
        profile.speedBonus += 0.05;
        break;
      case UpgradeType.size:
        profile.sizeBonus += 0.05;
        break;
      case UpgradeType.score:
        profile.scoreBonus += 0.1;
        break;
    }
  }
}
