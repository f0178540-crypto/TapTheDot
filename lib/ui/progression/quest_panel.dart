import 'package:flutter/material.dart';

class QuestPanel extends StatelessWidget {
  final int hits;
  final int perfect;

  const QuestPanel({super.key, required this.hits, required this.perfect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Daily Quests'),
        Text('Hits: $hits / 50'),
        Text('Perfect: $perfect / 5'),
      ],
    );
  }
}
