class LeaderboardEntry {
  final String playerId;
  final String modeId;
  final int score;
  final DateTime timestamp;

  LeaderboardEntry({
    required this.playerId,
    required this.modeId,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'modeId': modeId,
        'score': score,
        'timestamp': timestamp.toIso8601String(),
      };

  static LeaderboardEntry fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      playerId: json['playerId'],
      modeId: json['modeId'],
      score: json['score'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
