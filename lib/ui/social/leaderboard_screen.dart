import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        final list = ctrl.leaderboardManager
            .topByMode(ctrl.currentMode.id, limit: 20);

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final e = list[i];
            return Card(
              child: ListTile(
                leading: Text("#${i + 1}"),
                title: Text(e.playerId),
                trailing: Text(e.score.toString()),
              ),
            );
          },
        );
      },
    );
  }
}
