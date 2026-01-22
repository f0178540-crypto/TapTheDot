import 'package:flutter/material.dart';
import '../game/game_controller.dart';
import '../meta/upgrades.dart';

class HudOverlay extends StatelessWidget {
  final GameController controller;

  const HudOverlay({
    super.key,
    required this.controller,
  });

  Widget _badge(String label, int level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        "$label +$level",
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final extra = controller.upgrades[UpgradeId.extraTimeWindow] ?? 0;
    final disc = controller.upgrades[UpgradeId.reviveDiscount] ?? 0;
    final boost = controller.upgrades[UpgradeId.scoreBoost] ?? 0;
    final start = controller.upgrades[UpgradeId.startingStreak] ?? 0;

    final xpNeeded = 100 + (controller.level * 40);
    final xpProgress = (controller.xp / xpNeeded).clamp(0.0, 1.0);

    return Positioned(
      top: 30,
      left: 12,
      right: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== TOP ROW: SCORE / COINS / LEVEL =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Score: ${controller.score}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Coins: ${controller.coins}",
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  "LV ${controller.level}",
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ===== XP BAR =====
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: xpProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ===== STREAK =====
          if (controller.streak > 1)
            Text(
              "STREAK: ${controller.streak}",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(height: 8),

          // ===== UPGRADE BADGES =====
          Row(
            children: [
              _badge("Perfect", extra),
              const SizedBox(width: 8),
              _badge("Revive", disc),
              const SizedBox(width: 8),
              _badge("Score", boost),
              const SizedBox(width: 8),
              _badge("Start", start),
            ],
          ),
        ],
      ),
    );
  }
}
