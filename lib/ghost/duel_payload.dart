class DuelPayload {
  final int yourScore;
  final int ghostScore;
  final bool win;

  DuelPayload({
    required this.yourScore,
    required this.ghostScore,
    required this.win,
  });

  Map<String, dynamic> toJson() => {
        'yourScore': yourScore,
        'ghostScore': ghostScore,
        'win': win,
      };
}
