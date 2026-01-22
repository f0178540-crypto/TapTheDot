typedef VoidCallback = void Function();

class GameplaySignals {
  static final GameplaySignals I = GameplaySignals._();
  GameplaySignals._();

  final List<VoidCallback> _onPerfectHit = [];
  final List<VoidCallback> _onComboLevelUp = [];
  final List<VoidCallback> _onComboBreak = [];

  void onPerfectHit(VoidCallback cb) => _onPerfectHit.add(cb);
  void onComboLevelUp(VoidCallback cb) => _onComboLevelUp.add(cb);
  void onComboBreak(VoidCallback cb) => _onComboBreak.add(cb);

  void emitPerfectHit() {
    for (final cb in _onPerfectHit) cb();
  }

  void emitComboLevelUp() {
    for (final cb in _onComboLevelUp) cb();
  }

  void emitComboBreak() {
    for (final cb in _onComboBreak) cb();
  }
}
