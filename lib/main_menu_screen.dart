import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/upgrade_screen.dart';
import 'ui/meta/missions_screen.dart';
import 'ui/meta/achievements_list_screen.dart';
import 'meta/missions.dart';
import 'meta/achievements.dart';

class MainMenuScreen extends StatefulWidget {
  final VoidCallback onPlay;
  final VoidCallback onSkins;

  const MainMenuScreen({
    super.key,
    required this.onPlay,
    required this.onSkins,
  });

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  bool _hasMissionReward = false;
  bool _hasNewAchievement = false;

  @override
  void initState() {
    super.initState();
    _checkMeta();
  }

  Future<void> _checkMeta() async {
    final prefs = await SharedPreferences.getInstance();

    // missions badge
    final mission = await Missions.getOrCreateToday(prefs);
    final progress = Missions.getProgress(prefs);
    final claimed = Missions.isClaimed(prefs);
    final missionReady = progress >= mission.target && !claimed;

    // achievements badge (any unlocked)
    bool anyUnlocked = false;
    for (final a in Achievements.all) {
      if (await Achievements.isUnlocked(prefs, a.id)) {
        anyUnlocked = true;
        break;
      }
    }

    if (mounted) {
      setState(() {
        _hasMissionReward = missionReady;
        _hasNewAchievement = anyUnlocked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TAP THE DOT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: widget.onPlay,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                child: Text('PLAY', style: TextStyle(fontSize: 20)),
              ),
            ),

            const SizedBox(height: 14),

            // ===== MISSIONS =====
            Stack(
              clipBehavior: Clip.none,
              children: [
                TextButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MissionsScreen()),
                    );
                    _checkMeta();
                  },
                  child: const Text(
                    'MISSIONS',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                if (_hasMissionReward)
                  Positioned(
                    right: -4,
                    top: -2,
                    child: _badge(),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // ===== ACHIEVEMENTS =====
            Stack(
              clipBehavior: Clip.none,
              children: [
                TextButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AchievementsListScreen(),
                      ),
                    );
                    _checkMeta();
                  },
                  child: const Text(
                    'ACHIEVEMENTS',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                if (_hasNewAchievement)
                  Positioned(
                    right: -4,
                    top: -2,
                    child: _badge(),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UpgradeScreen()),
                );
              },
              child: const Text(
                'UPGRADES',
                style: TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 14),

            TextButton(
              onPressed: widget.onSkins,
              child: const Text(
                'SKINS',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge() {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      ),
    );
  }
}
