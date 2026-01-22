import 'game_mode.dart';
import 'survival_rules.dart';
import 'time_attack_rules.dart';
import 'daily_seed_rules.dart';

class ModeManager {
  GameMode mode = GameMode.classic;

  final SurvivalRules survival = SurvivalRules();
  final TimeAttackRules timeAttack = TimeAttackRules();
  final DailySeedRules dailySeed = DailySeedRules();

  void setMode(GameMode m) {
    mode = m;

    if (mode == GameMode.survival) {
      survival.reset();
    }

    if (mode == GameMode.timeAttack) {
      timeAttack.reset();
    }

    if (mode == GameMode.dailySeed) {
      dailySeed.reset();
    }
  }

  bool get isClassic => mode == GameMode.classic;
  bool get isSurvival => mode == GameMode.survival;
  bool get isTimeAttack => mode == GameMode.timeAttack;
  bool get isDailySeed => mode == GameMode.dailySeed;
}
