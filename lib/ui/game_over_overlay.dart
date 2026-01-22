import 'package:flutter/material.dart';
import '../game/game_controller.dart';

class GameOverOverlay extends StatelessWidget {
  final GameController controller;
  final VoidCallback onRetry;
  final VoidCallback onRevive;

  const GameOverOverlay({
    super.key,
    required this.controller,
    required this.onRetry,
    required this.onRevive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.75),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "GAME OVER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Score: ${controller.score}",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                "Best: ${controller.bestScore}",
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Level: ${controller.level}",
                style: const TextStyle(color: Colors.greenAccent, fontSize: 14),
              ),
              Text(
                "Coins this run: ${controller.coins}",
                style: const TextStyle(color: Colors.amber, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRetry,
                      child: const Text("RETRY"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.canAffordRevive ? onRevive : null,
                      child: Text("REVIVE (${controller.reviveCost()})"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
