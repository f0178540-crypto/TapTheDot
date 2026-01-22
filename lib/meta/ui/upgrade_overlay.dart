import 'package:flutter/material.dart';
import '../upgrade_system.dart';

typedef UpgradeCallback = void Function(UpgradeType type);

class UpgradeOverlay extends StatelessWidget {
  final UpgradeCallback onSelect;

  const UpgradeOverlay({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.75),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'LEVEL UP!',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 20),
              _btn(context, 'Speed Boost', () => onSelect(UpgradeType.speed)),
              _btn(context, 'Bigger Targets', () => onSelect(UpgradeType.size)),
              _btn(context, 'Score Bonus', () => onSelect(UpgradeType.score)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btn(BuildContext ctx, String text, VoidCallback cb) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: cb,
        child: SizedBox(
          width: 180,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
