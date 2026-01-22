import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class SkillTreeScreen extends StatelessWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: ctrl.skillTree.nodes.values.map((n) {
            return Card(
              child: ListTile(
                title: Text(n.type.name),
                subtitle: Text("Level ${n.level}/${n.maxLevel}"),
                trailing: ElevatedButton(
                  onPressed: () => ctrl.upgradeSkill(n.type),
                  child: Text("Upgrade (${n.nextCost()})"),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
