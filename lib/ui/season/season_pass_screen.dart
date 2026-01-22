import 'package:flutter/material.dart';
import '../../season_pass/season_rewards.dart';
import '../../season_pass/season_progress.dart';

class SeasonPassScreen extends StatefulWidget {
  const SeasonPassScreen({super.key});

  @override
  State<SeasonPassScreen> createState() => _SeasonPassScreenState();
}

class _SeasonPassScreenState extends State<SeasonPassScreen> {
  final progress = SeasonProgress();
  int level = 1;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    level = await progress.level();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Season Pass')),
      body: ListView(
        children: SeasonRewards.levels.map((l) {
          final unlocked = l.level <= level;
          return ListTile(
            title: Text('Level ${l.level}'),
            subtitle: Text('${l.rewardCoins} coins'),
            trailing: Icon(unlocked ? Icons.check_circle : Icons.lock),
          );
        }).toList(),
      ),
    );
  }
}
