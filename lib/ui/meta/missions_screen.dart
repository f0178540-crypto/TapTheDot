import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../meta/missions.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({super.key});

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  DailyMission? _mission;
  int _progress = 0;
  bool _claimed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final mission = await Missions.getOrCreateToday(prefs);
    final progress = Missions.getProgress(prefs);
    final claimed = Missions.isClaimed(prefs);

    setState(() {
      _mission = mission;
      _progress = progress;
      _claimed = claimed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final m = _mission;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("MISSIONS"),
        centerTitle: true,
      ),
      body: m == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titleFor(m.type),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _descFor(m.type, m.target),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    LinearProgressIndicator(
                      value: (_progress / m.target).clamp(0, 1),
                      minHeight: 10,
                      backgroundColor: Colors.white12,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _progress >= m.target
                            ? Colors.greenAccent
                            : Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$_progress / ${m.target}",
                          style: const TextStyle(color: Colors.white60),
                        ),
                        _rewardBadge("+${m.rewardCoins} COINS"),
                      ],
                    ),
                    const Spacer(),
                    if (_progress >= m.target && !_claimed)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _claim,
                          child: const Text("CLAIM"),
                        ),
                      ),
                    if (_claimed)
                      const Center(
                        child: Text(
                          "CLAIMED",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _claim() async {
    final prefs = await SharedPreferences.getInstance();
    await Missions.markClaimed(prefs);

    setState(() {
      _claimed = true;
    });
  }

  String _titleFor(MissionType t) {
    switch (t) {
      case MissionType.hitCount:
        return "HIT TARGETS";
      case MissionType.perfectCount:
        return "PERFECT HITS";
      case MissionType.riskKills:
        return "RISK SLAYER";
      case MissionType.reachLevel:
        return "REACH LEVEL";
    }
  }

  String _descFor(MissionType t, int target) {
    switch (t) {
      case MissionType.hitCount:
        return "Hit $target dots";
      case MissionType.perfectCount:
        return "Get $target perfect hits";
      case MissionType.riskKills:
        return "Kill $target risk dots";
      case MissionType.reachLevel:
        return "Reach level $target";
    }
  }

  Widget _rewardBadge(String reward) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amberAccent),
      ),
      child: Text(
        reward,
        style: const TextStyle(
          color: Colors.amberAccent,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
