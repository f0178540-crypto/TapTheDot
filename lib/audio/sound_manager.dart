import 'dart:math';
import 'package:flutter/services.dart';

class SoundManager {
  static final _rng = Random();

  // postojeći kanal
  static const MethodChannel _channel =
      MethodChannel('tap_the_dot/sound');

  // === BACKWARD COMPAT ===
  static Future<void> hit() async {
    await _play('hit_1');
  }

  // === COMBO PITCH FEEL (SAMPLE VARIANTS) ===
  static Future<void> hitWithCombo(int combo, bool rageMode) async {
    String sample = 'hit_1';

    if (combo >= 10) {
      sample = 'hit_5';
    } else if (combo >= 7) {
      sample = 'hit_4';
    } else if (combo >= 5) {
      sample = 'hit_3';
    } else if (combo >= 3) {
      sample = 'hit_2';
    }

    // rage mode slight random spice
    if (rageMode && _rng.nextBool()) {
      sample = 'hit_${min(5, (sample == 'hit_5' ? 5 : int.parse(sample.split('_')[1]) + 1))}';
    }

    await _play(sample);
  }

  static Future<void> _play(String name) async {
    try {
      await _channel.invokeMethod('play', name);
    } catch (_) {
      // fail silently — gameplay must never crash
    }
  }
}
