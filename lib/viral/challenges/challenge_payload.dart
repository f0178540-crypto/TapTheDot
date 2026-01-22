class ChallengePayload {
  final int seed;
  final int score;
  final String fromPlayer;

  ChallengePayload({
    required this.seed,
    required this.score,
    required this.fromPlayer,
  });
}
