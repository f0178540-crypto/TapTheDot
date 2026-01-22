import 'package:flutter/material.dart';

class StarterPackCard extends StatelessWidget {
  final VoidCallback onBuy;

  const StarterPackCard({super.key, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Starter Pack'),
        subtitle: const Text('+300 coins'),
        trailing: ElevatedButton(onPressed: onBuy, child: const Text('€0.99')),
      ),
    );
  }
}
