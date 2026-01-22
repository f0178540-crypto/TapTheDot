class ShareCardPayload {
  final int score;
  final int bestCombo;
  final int winStreak;
  final String? cosmeticId;
  final String tag;

  ShareCardPayload({
    required this.score,
    required this.bestCombo,
    required this.winStreak,
    required this.cosmeticId,
    required this.tag,
  });
}
