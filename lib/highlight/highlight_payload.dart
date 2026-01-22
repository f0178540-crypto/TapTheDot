class HighlightPayload {
  final int score;
  final int combo;
  final int seed;
  final String tag; // CLUTCH / BOSS / STREAK

  HighlightPayload({
    required this.score,
    required this.combo,
    required this.seed,
    required this.tag,
  });

  Map<String, dynamic> toJson() => {
        'score': score,
        'combo': combo,
        'seed': seed,
        'tag': tag,
      };

  static HighlightPayload fromJson(Map<String, dynamic> m) {
    return HighlightPayload(
      score: m['score'] ?? 0,
      combo: m['combo'] ?? 0,
      seed: m['seed'] ?? 0,
      tag: m['tag'] ?? '',
    );
  }
}
