import 'dart:async';
import 'powerup_type.dart';

class PowerupManager {
  bool slowMoActive = false;
  bool shieldActive = false;

  Timer? _slowMoTimer;

  void activate(PowerupType t) {
    if (t == PowerupType.slowMo) {
      slowMoActive = true;
      _slowMoTimer?.cancel();
      _slowMoTimer = Timer(const Duration(seconds: 3), () {
        slowMoActive = false;
      });
    } else if (t == PowerupType.shield) {
      shieldActive = true;
    }
  }

  bool consumeShield() {
    if (!shieldActive) return false;
    shieldActive = false;
    return true;
  }

  void reset() {
    slowMoActive = false;
    shieldActive = false;
    _slowMoTimer?.cancel();
  }

  void dispose() {
    _slowMoTimer?.cancel();
  }
}
