import 'skill_type.dart';

class SkillNode {
  final SkillType type;
  final int maxLevel;
  int level;
  final double valuePerLevel;
  final int costBase;

  SkillNode({
    required this.type,
    required this.maxLevel,
    required this.valuePerLevel,
    required this.costBase,
    this.level = 0,
  });

  bool get isMaxed => level >= maxLevel;

  int nextCost() {
    return costBase * (level + 1);
  }

  double totalValue() {
    return level * valuePerLevel;
  }

  void upgrade() {
    if (!isMaxed) {
      level += 1;
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type.index,
        'level': level,
      };

  static SkillNode fromJson(
    Map<String, dynamic> json,
    SkillNode template,
  ) {
    return SkillNode(
      type: template.type,
      maxLevel: template.maxLevel,
      valuePerLevel: template.valuePerLevel,
      costBase: template.costBase,
      level: json['level'] ?? 0,
    );
  }
}
