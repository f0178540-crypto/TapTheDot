import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class CloudService {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp();
      _initialized = true;
      debugPrint("Firebase initialized");
    } catch (e) {
      debugPrint("Firebase init failed: $e");
      rethrow;
    }
  }

  static bool get isReady => _initialized;
}
