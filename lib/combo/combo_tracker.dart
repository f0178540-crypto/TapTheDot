import '../core/gameplay_signals.dart';

class ComboTracker {
  int _combo = 0;
  double _decayTimer = 0;

  static const double decayWindow = 1.2;

  int get combo => _combo;

  void update(double dt) {
    if (_combo == 0) return;

    _decayTimer -= dt;
    if (_decayTimer <= 0) {
      _combo = 0;
      GameplaySignals.I.emitComboBreak();
    }
  }

  void onPerfectHit() {
    _combo++;
    _decayTimer = decayWindow;

    GameplaySignals.I.emitPerfectHit();

    if (_combo == 5 || _combo == 10 || _combo == 20) {
      GameplaySignals.I.emitComboLevelUp();
    }
  }

  void onMiss() {
    if (_combo > 0) {
      _combo = 0;
      GameplaySignals.I.emitComboBreak();
    }
  }

  void reset() {
    _combo = 0;
    _decayTimer = 0;
  }
}
