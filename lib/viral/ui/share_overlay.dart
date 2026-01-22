import 'package:flutter/material.dart';
import '../highlight_event.dart';

typedef ShareAction = void Function();

class ShareOverlay extends StatelessWidget {
  final HighlightEvent event;
  final ShareAction onShare;
  final ShareAction onClose;

  const ShareOverlay({
    super.key,
    required this.event,
    required this.onShare,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'HIGHLIGHT!',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              const SizedBox(height: 8),
              Text(
                'Score: ${event.score}  Combo: ${event.combo}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onShare,
                child: const Text('Share'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: onClose,
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
