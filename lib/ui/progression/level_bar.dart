import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final int level;
  final double progress;

  const LevelBar({super.key, required this.level, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Level $level'),
        LinearProgressIndicator(value: progress),
      ],
    );
  }
}
