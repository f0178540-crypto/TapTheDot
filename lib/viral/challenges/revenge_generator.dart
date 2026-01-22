import 'challenge_payload.dart';

class RevengeGenerator {
  ChallengePayload buildRevenge({
    required int seed,
    required int score,
    required String fromPlayer,
  }) {
    return ChallengePayload(
      seed: seed,
      score: score,
      fromPlayer: fromPlayer,
    );
  }
}
