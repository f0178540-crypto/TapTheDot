import 'dart:math';
import 'invite_payload.dart';

class InviteManager {
  InvitePayload? lastInvite;
  bool hasPendingBoost = false;

  InvitePayload generateInvite() {
    final code = _randomCode(6);
    lastInvite = InvitePayload(code: code, created: DateTime.now());
    return lastInvite!;
  }

  void acceptInvite(String code) {
    // lokalno simulirano — server kasnije
    hasPendingBoost = true;
  }

  void consumeBoost() {
    hasPendingBoost = false;
  }

  String _randomCode(int len) {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = Random();
    return List.generate(len, (_) => chars[rnd.nextInt(chars.length)]).join();
  }
}
