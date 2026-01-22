import 'package:flutter/material.dart';

typedef ChallengeAction = void Function();

class ChallengeAcceptOverlay extends StatelessWidget {
  final String token;
  final ChallengeAction onAccept;
  final ChallengeAction onClose;

  const ChallengeAcceptOverlay({
    super.key,
    required this.token,
    required this.onAccept,
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
                'FRIEND CHALLENGE',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                'Token: $token',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onAccept,
                child: const Text('Accept'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: onClose,
                child: const Text('Later'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
