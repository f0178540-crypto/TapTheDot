import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';

class DailyRewardPopup extends StatelessWidget {
  const DailyRewardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<GameController>();
    final reward = ctrl.streakManager.claim();

    if (reward == null) return const SizedBox.shrink();

    ctrl.addCoins(reward.coins);
    if (reward.boost) {
      ctrl.boostManager.addRandom();
    }

    return AlertDialog(
      title: const Text("Daily Reward!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Day ${reward.day}"),
          const SizedBox(height: 8),
          Text("+${reward.coins} coins"),
          if (reward.boost) const Text("Bonus Boost!"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        )
      ],
    );
  }
}
