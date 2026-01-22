import 'game_mode.dart';

class PrecisionMode implements GameMode {
  @override
  String get id => "precision";

  @override
  String get name => "Precision";

  @override
  int initialTimeMs() => 30000;

  @override
  double radiusMultiplier() => 0.75;

  @override
  double spawnRateMultiplier() => 1.0;

  @override
  double scoreMultiplier() => 1.5;
}
