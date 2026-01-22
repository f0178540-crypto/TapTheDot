import 'game_mode.dart';

class TimeAttackMode implements GameMode {
  @override
  String get id => "time_attack";

  @override
  String get name => "Time Attack";

  @override
  int initialTimeMs() => 60000;

  @override
  double radiusMultiplier() => 1.0;

  @override
  double spawnRateMultiplier() => 1.25;

  @override
  double scoreMultiplier() => 1.2;
}
