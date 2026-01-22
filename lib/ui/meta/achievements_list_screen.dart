import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../meta/achievements.dart';

class AchievementsListScreen extends StatefulWidget {
  const AchievementsListScreen({super.key});

  @override
  State<AchievementsListScreen> createState() => _AchievementsListScreenState();
}

class _AchievementsListScreenState extends State<AchievementsListScreen> {
  final Map<AchievementId, bool> _unlocked = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    for (final a in Achievements.all) {
      final v = await Achievements.isUnlocked(prefs, a.id);
      _unlocked[a.id] = v;
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("ACHIEVEMENTS"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: Achievements.all.length,
        itemBuilder: (context, i) {
          final a = Achievements.all[i];
          final ok = _unlocked[a.id] ?? false;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: ok
                  ? Colors.greenAccent.withOpacity(0.08)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: ok ? Colors.greenAccent : Colors.white24,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  ok ? Icons.emoji_events : Icons.lock_outline,
                  color: ok ? Colors.greenAccent : Colors.white38,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title(a.id),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _desc(a.id),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (ok)
                  Text(
                    "+${a.rewardCoins}",
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _title(AchievementId id) {
    switch (id) {
      case AchievementId.firstHit:
        return "First Blood";
      case AchievementId.combo5:
        return "Combo x5";
      case AchievementId.combo10:
        return "Combo x10";
      case AchievementId.perfect3:
        return "Perfect Streak";
      case AchievementId.riskSlayer5:
        return "Risk Slayer";
      case AchievementId.reachLevel10:
        return "Level 10";
    }
  }

  String _desc(AchievementId id) {
    switch (id) {
      case AchievementId.firstHit:
        return "Hit your first dot";
      case AchievementId.combo5:
        return "Reach combo chain of 5";
      case AchievementId.combo10:
        return "Reach combo chain of 10";
      case AchievementId.perfect3:
        return "3 perfect hits in a row";
      case AchievementId.riskSlayer5:
        return "Kill 5 risk dots";
      case AchievementId.reachLevel10:
        return "Reach level 10";
    }
  }
}
