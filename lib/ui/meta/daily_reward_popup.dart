import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class DailyRewardPopup extends StatelessWidget {
  const DailyRewardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.read<GameController>();
    final reward = ctrl.dailyManager.currentReward();

    return AlertDialog(
      title: const Text("Daily Reward 🎁"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Day ${reward.day}"),
          const SizedBox(height: 12),
          Text("+${reward.coins} coins"),
          if (reward.boost != null) ...[
            const SizedBox(height: 6),
            Text("Boost: ${reward.boost}"),
          ],
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await ctrl.claimDailyReward();
            Navigator.of(context).pop();
          },
          child: const Text("CLAIM"),
        ),
      ],
    );
  }
}
