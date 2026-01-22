import '../../viral/challenges/challenge_payload.dart';
import '../../social/ghost_race/ghost_race_payload.dart';

class AsyncDuelManager {
  ChallengePayload? activeDuel;

  ChallengePayload createChallengeFromGhost(GhostRacePayload payload) {
    return ChallengePayload(
      seed: payload.runId.hashCode,
      score: payload.finalScore,
    );
  }

  void acceptDuel(ChallengePayload payload) {
    activeDuel = payload;
  }

  void clear() {
    activeDuel = null;
  }
}
