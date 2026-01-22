import 'game_mode.dart';

class ChaosMode implements GameMode {
  @override
  String get id => "chaos";

  @override
  String get name => "Chaos";

  @override
  int initialTimeMs() => 35000;

  @override
  double radiusMultiplier() => 0.9;

  @override
  double spawnRateMultiplier() => 1.8;

  @override
  double scoreMultiplier() => 1.3;
}
