import 'mission_type.dart';

class Mission {
  final MissionType type;
  final int targetValue;
  int progress;
  final int rewardCoins;
  bool claimed;

  Mission({
    required this.type,
    required this.targetValue,
    required this.rewardCoins,
    this.progress = 0,
    this.claimed = false,
  });

  bool get completed => progress >= targetValue;

  void add(int v) {
    if (!completed) {
      progress += v;
      if (progress > targetValue) progress = targetValue;
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'progress': progress,
        'claimed': claimed,
      };

  static Mission fromJson(
    Map<String, dynamic> json,
    Mission template,
  ) {
    return Mission(
      type: template.type,
      targetValue: template.targetValue,
      rewardCoins: template.rewardCoins,
      progress: json['progress'] ?? 0,
      claimed: json['claimed'] ?? false,
    );
  }
}
