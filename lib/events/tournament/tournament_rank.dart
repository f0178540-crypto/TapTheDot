class TournamentRank {
  final String userId;
  final int score;
  final int rank;
  final int totalPlayers;

  TournamentRank({
    required this.userId,
    required this.score,
    required this.rank,
    required this.totalPlayers,
  });

  int get percent =>
      totalPlayers == 0 ? 100 : ((rank / totalPlayers) * 100).ceil();
}
