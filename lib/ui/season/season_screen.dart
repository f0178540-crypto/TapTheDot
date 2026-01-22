import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class SeasonScreen extends StatelessWidget {
  const SeasonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        final xp = ctrl.seasonManager.xp;
        final next = ctrl.seasonManager.nextLevelXp();

        final progress = (xp / next).clamp(0.0, 1.0);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Season Progress",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 8),
              Text("$xp / $next XP"),
              const SizedBox(height: 24),
              const Text(
                "Rewards unlock automatically as you level up.",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }
}
