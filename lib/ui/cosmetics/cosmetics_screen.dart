import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game/game_controller.dart';

class CosmeticsScreen extends StatelessWidget {
  const CosmeticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        return GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          children: ctrl.cosmeticManager.skins.map((s) {
            return Card(
              child: InkWell(
                onTap: () => ctrl.buySkin(s.id),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: s.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(s.name),
                    Text(s.unlocked ? "Unlocked" : "${s.price} coins"),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
