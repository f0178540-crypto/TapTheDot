import 'package:flutter/material.dart';

import '../social/challenge_screen.dart';
import '../social/leaderboard_screen.dart';
import '../viral/share_screen.dart';
import '../meta/upgrade_screen.dart';

class ReplayScreen extends StatelessWidget {
  final VoidCallback onReplay;

  const ReplayScreen({super.key, required this.onReplay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: onReplay,
              child: const Text('Replay'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UpgradeScreen()),
                );
              },
              child: const Text('Upgrades'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                );
              },
              child: const Text('Leaderboard'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChallengeScreen()),
                );
              },
              child: const Text('Challenges'),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ShareScreen()),
                );
              },
              child: const Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
