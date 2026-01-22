import '../../viral/challenges/challenge_payload.dart';

class RematchManager {
  ChallengePayload? lastOpponent;

  void recordOpponent(ChallengePayload payload) {
    lastOpponent = payload;
  }

  ChallengePayload? get rematchPayload => lastOpponent;

  void clear() {
    lastOpponent = null;
  }
}
