import 'package:flutter/material.dart';

class SessionOfferDialog extends StatelessWidget {
  final VoidCallback onAccept;

  const SessionOfferDialog({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('One more try?'),
      content: const Text('Watch ad or buy Starter Pack.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('NO')),
        ElevatedButton(onPressed: onAccept, child: const Text('GO')),
      ],
    );
  }
}
