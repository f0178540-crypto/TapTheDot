import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ReferralManager {
  static const _codeKey = "referral_code";
  static const _usedKey = "referral_used";

  String? _code;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _code = prefs.getString(_codeKey);

    if (_code == null) {
      _code = _generateCode();
      await prefs.setString(_codeKey, _code!);
    }
  }

  String get code => _code ?? "----";

  Future<bool> applyReferral(String inputCode) async {
    final prefs = await SharedPreferences.getInstance();

    final used = prefs.getBool(_usedKey) ?? false;
    if (used) return false;

    if (inputCode.length < 5) return false;

    await prefs.setBool(_usedKey, true);
    return true;
  }

  String _generateCode() {
    const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    final rnd = Random();
    return List.generate(6, (_) => chars[rnd.nextInt(chars.length)]).join();
  }
}
