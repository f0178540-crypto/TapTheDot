import '../core/gameplay_signals.dart';

class SlowMoEffect {
  double factor = 1.0;
  double _time = 0;

  SlowMoEffect() {
    GameplaySignals.I.onComboLevelUp(() {
      trigger(0.25);
    });
  }

  void trigger(double duration) {
    factor = 0.35;
    _time = duration;
  }

  void update(double dt) {
    if (_time <= 0) {
      factor = 1.0;
      return;
    }
    _time -= dt;
  }
}
