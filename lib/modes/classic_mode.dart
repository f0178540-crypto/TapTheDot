import 'game_mode.dart';

class ClassicMode implements GameMode {
  @override
  String get id => "classic";

  @override
  String get name => "Classic";

  @override
  int initialTimeMs() => 30000;

  @override
  double radiusMultiplier() => 1.0;

  @override
  double spawnRateMultiplier() => 1.0;

  @override
  double scoreMultiplier() => 1.0;
}
