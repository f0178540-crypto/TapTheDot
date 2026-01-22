import 'package:flutter/material.dart';
import '../../events/event_config.dart';

class EventPopup extends StatelessWidget {
  final GameEvent event;
  final VoidCallback onClose;

  const EventPopup({super.key, required this.event, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(event.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Special rules active this week!'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onClose, child: const Text('Play')),
            ],
          ),
        ),
      ),
    );
  }
}
