import 'package:flutter/material.dart';

class DailyRewardPopup extends StatelessWidget {
  final int coins;
  final VoidCallback onClose;

  const DailyRewardPopup({super.key, required this.coins, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Daily Reward', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('+ $coins Coins', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onClose, child: const Text('Collect')),
            ],
          ),
        ),
      ),
    );
  }
}
