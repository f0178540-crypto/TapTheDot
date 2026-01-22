import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'skill_node.dart';
import 'skill_type.dart';

class SkillTree {
  final Map<SkillType, SkillNode> nodes;

  SkillTree(this.nodes);

  static SkillTree createDefault() {
    return SkillTree({
      SkillType.extraTime: SkillNode(
        type: SkillType.extraTime,
        maxLevel: 10,
        valuePerLevel: 500, // ms
        costBase: 50,
      ),
      SkillType.biggerRadius: SkillNode(
        type: SkillType.biggerRadius,
        maxLevel: 8,
        valuePerLevel: 0.04, // +4%
        costBase: 60,
      ),
      SkillType.bonusTimeBoost: SkillNode(
        type: SkillType.bonusTimeBoost,
        maxLevel: 8,
        valuePerLevel: 0.15, // +15%
        costBase: 80,
      ),
      SkillType.bombChanceReduce: SkillNode(
        type: SkillType.bombChanceReduce,
        maxLevel: 6,
        valuePerLevel: 0.05, // -5%
        costBase: 120,
      ),
    });
  }

  double getExtraTimeMs() =>
      nodes[SkillType.extraTime]!.totalValue();

  double getRadiusMultiplier() =>
      1.0 + nodes[SkillType.biggerRadius]!.totalValue();

  double getBonusTimeMultiplier() =>
      1.0 + nodes[SkillType.bonusTimeBoost]!.totalValue();

  double getBombChanceReduction() =>
      nodes[SkillType.bombChanceReduce]!.totalValue();

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final map = nodes.map((k, v) => MapEntry(k.index.toString(), v.toJson()));
    prefs.setString('skill_tree', jsonEncode(map));
  }

  static Future<SkillTree> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('skill_tree');

    final template = createDefault();

    if (raw == null) return template;

    final decoded = jsonDecode(raw) as Map<String, dynamic>;

    final nodes = <SkillType, SkillNode>{};

    for (final entry in template.nodes.entries) {
      final key = entry.key.index.toString();
      if (decoded.containsKey(key)) {
        nodes[entry.key] =
            SkillNode.fromJson(decoded[key], entry.value);
      } else {
        nodes[entry.key] = entry.value;
      }
    }

    return SkillTree(nodes);
  }
}
