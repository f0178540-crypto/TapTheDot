import 'package:flutter/material.dart';

class ReviveDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const ReviveDialog({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Continue?'),
      content: const Text('Watch an ad to revive and continue the run.'),
      actions: [
        TextButton(onPressed: onDecline, child: const Text('NO')),
        ElevatedButton(onPressed: onAccept, child: const Text('WATCH AD')),
      ],
    );
  }
}
