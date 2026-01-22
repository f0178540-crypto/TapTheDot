import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game/game_controller.dart';

class SkinSelectScreen extends StatelessWidget {
  final VoidCallback onBack;

  const SkinSelectScreen({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    final skins = [
      (const Color(0xFF2196F3), 1, 0),
      (const Color(0xFF4CAF50), 3, 50),
      (const Color(0xFFFF9800), 5, 80),
      (const Color(0xFFE91E63), 8, 120),
      (const Color(0xFF9C27B0), 12, 200),
    ];

    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'SKINS',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 30),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: skins.map((s) {
                  final color = s.$1;
                  final unlockLevel = s.$2;
                  final cost = s.$3;

                  final unlocked = controller.level >= unlockLevel;
                  final owned = controller.purchasedSkins.contains(color);
                  final selected = controller.selectedColor == color;

                  return GestureDetector(
                    onTap: owned
                        ? () => controller.selectColor(color)
                        : unlocked
                            ? () => controller.purchaseSkin(color, cost)
                            : null,
                    child: Opacity(
                      opacity: unlocked ? 1.0 : 0.3,
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selected
                                    ? Colors.white
                                    : Colors.white24,
                                width: selected ? 3 : 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          if (!unlocked)
                            Text(
                              'LV $unlockLevel',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            )
                          else if (!owned && cost > 0)
                            Text(
                              '$cost',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 12,
                              ),
                            )
                          else
                            const Text(
                              'OWNED',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Text(
                'Coins: ${controller.coins}',
                style: const TextStyle(color: Colors.amber, fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: onBack,
                child: const Text(
                  'BACK',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
