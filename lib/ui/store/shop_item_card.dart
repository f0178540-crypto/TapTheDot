import 'package:flutter/material.dart';

class ShopItemCard extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onBuy;

  const ShopItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: ElevatedButton(onPressed: onBuy, child: Text(price)),
      ),
    );
  }
}
