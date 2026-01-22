import '../modes/game_mode.dart';

class ModeRewardScaler {
  static double xpMultiplier(GameMode mode) {
    switch (mode) {
      case GameMode.survival:
        return 1.25;
      case GameMode.timeAttack:
        return 1.15;
      case GameMode.dailySeed:
        return 1.35;
      case GameMode.classic:
      default:
        return 1.0;
    }
  }

  static double coinMultiplier(GameMode mode) {
    switch (mode) {
      case GameMode.survival:
        return 1.3;
      case GameMode.timeAttack:
        return 1.1;
      case GameMode.dailySeed:
        return 1.5;
      case GameMode.classic:
      default:
        return 1.0;
    }
  }
}
