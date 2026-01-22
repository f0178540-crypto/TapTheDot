class Challenge {
  final String code;       // shareable
  final String modeId;
  final int targetScore;
  final DateTime createdAt;

  Challenge({
    required this.code,
    required this.modeId,
    required this.targetScore,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'code': code,
        'modeId': modeId,
        'targetScore': targetScore,
        'createdAt': createdAt.toIso8601String(),
      };

  static Challenge fromJson(Map<String, dynamic> json) {
    return Challenge(
      code: json['code'],
      modeId: json['modeId'],
      targetScore: json['targetScore'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
