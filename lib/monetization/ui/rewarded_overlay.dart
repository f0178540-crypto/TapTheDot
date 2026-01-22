import 'package:flutter/material.dart';

typedef RewardAction = void Function();
typedef CloseAction = void Function();

class RewardedOverlay extends StatelessWidget {
  final RewardAction onWatch;
  final CloseAction onClose;

  const RewardedOverlay({
    super.key,
    required this.onWatch,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.85),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Get Free Coins',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'Watch a short video to earn 100 coins',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onWatch,
                child: const Text('Watch'),
              ),
              const SizedBox(height: 10),
              TextButton(onPressed: onClose, child: const Text('No thanks')),
            ],
          ),
        ),
      ),
    );
  }
}
