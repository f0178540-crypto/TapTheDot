import '../powerups/powerup_type.dart';

class LevelRewards {
  static List<PowerupType> rewardForLevel(int lvl) {
    if (lvl % 3 == 0) return [PowerupType.slowMo];
    if (lvl % 5 == 0) return [PowerupType.shield];
    return [];
  }
}
