import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../modes/game_mode.dart';

class ModeSelectScreen extends StatelessWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<GameController>();

    final modes = <GameMode>[
      ClassicMode(),
      HardMode(),
      ChaosMode(),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: modes.length,
      itemBuilder: (_, i) {
        final m = modes[i];
        return Card(
          child: ListTile(
            title: Text(m.id),
            subtitle: Text(
              "Score x${m.scoreMultiplier()} | Spawn x${m.spawnRateMultiplier()}",
            ),
            onTap: () {
              ctrl.setMode(m);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

/* ================= MODES ================= */

class ClassicMode implements GameMode {
  @override
  String get id => "Classic";

  @override
  double scoreMultiplier() => 1.0;

  @override
  double radiusMultiplier() => 1.0;

  @override
  double spawnRateMultiplier() => 1.0;

  @override
  int initialTimeMs() => 30000;
}

class HardMode implements GameMode {
  @override
  String get id => "Hard";

  @override
  double scoreMultiplier() => 1.5;

  @override
  double radiusMultiplier() => 0.9;

  @override
  double spawnRateMultiplier() => 1.2;

  @override
  int initialTimeMs() => 25000;
}

class ChaosMode implements GameMode {
  @override
  String get id => "Chaos";

  @override
  double scoreMultiplier() => 2.0;

  @override
  double radiusMultiplier() => 0.8;

  @override
  double spawnRateMultiplier() => 1.5;

  @override
  int initialTimeMs() => 20000;
}
