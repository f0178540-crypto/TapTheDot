import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game/game_controller.dart';
import '../meta/upgrades.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = context.watch<GameController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Upgrades'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // ===== COINS BAR =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Coins: ${gc.coins}',
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // ===== UPGRADE LIST =====
          Expanded(
            child: ListView.builder(
              itemCount: UpgradeTree.nodes.length,
              itemBuilder: (context, index) {
                final node = UpgradeTree.nodes[index];
                final level = gc.upgrades[node.id] ?? 0;
                final isMax = level >= node.maxLevel;

                final nextCost = isMax ? null : node.costs[level];
                final canBuy =
                    !isMax && nextCost != null && gc.canSpendCoins(nextCost);

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111111),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            node.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (isMax)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.greenAccent),
                              ),
                              child: const Text(
                                'MAX',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        node.description,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Level: $level / ${node.maxLevel}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          ElevatedButton(
                            onPressed: canBuy
                                ? () {
                                    final ok = gc.spendCoins(nextCost!);
                                    if (!ok) return;
                                    gc.setUpgradeLevel(node.id, level + 1);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  canBuy ? Colors.blueAccent : Colors.grey,
                            ),
                            child: Text(
                              isMax ? 'MAX' : 'Buy ($nextCost)',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
