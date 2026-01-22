class RivalryTracker {
  final Map<String, int> winCounts = {};

  void recordWin(String opponentId) {
    winCounts[opponentId] = (winCounts[opponentId] ?? 0) + 1;
  }

  int winsAgainst(String opponentId) {
    return winCounts[opponentId] ?? 0;
  }
}
