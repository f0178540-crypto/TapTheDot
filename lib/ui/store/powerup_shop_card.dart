import 'package:flutter/material.dart';

class PowerupShopCard extends StatelessWidget {
  final String title;
  final String cost;
  final VoidCallback onBuy;

  const PowerupShopCard({
    super.key,
    required this.title,
    required this.cost,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: ElevatedButton(onPressed: onBuy, child: Text(cost)),
      ),
    );
  }
}
