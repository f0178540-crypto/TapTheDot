import 'package:flutter/material.dart';

class ReviveOfferDialog extends StatelessWidget {
  final VoidCallback onAccept;

  const ReviveOfferDialog({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Revive?'),
      content: const Text('Use coins or watch ad.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('NO')),
        ElevatedButton(onPressed: onAccept, child: const Text('YES')),
      ],
    );
  }
}
