import 'package:flutter/material.dart';

class RemoveAdsCard extends StatelessWidget {
  final VoidCallback onBuy;

  const RemoveAdsCard({super.key, required this.onBuy});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Remove Ads PRO'),
        subtitle: const Text('No ads + extra revive'),
        trailing: ElevatedButton(onPressed: onBuy, child: const Text('€2.99')),
      ),
    );
  }
}
