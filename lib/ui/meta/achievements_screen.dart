import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: ctrl.achievementManager.achievements.map((a) {
            return Card(
              child: ListTile(
                title: Text(a.title),
                subtitle: Text(a.description),
                trailing: Icon(
                  a.unlocked ? Icons.check_circle : Icons.lock,
                  color: a.unlocked ? Colors.green : Colors.grey,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
