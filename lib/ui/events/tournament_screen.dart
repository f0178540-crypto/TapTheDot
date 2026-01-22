import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../events/tournament/tournament_rank.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({super.key});

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {
  bool loading = true;
  List<TournamentRank> ranks = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ctrl = context.read<GameController>();
    final uid = ctrl.tournamentManager.current == null ? null : null;

    if (ctrl.tournamentManager.current == null) {
      setState(() => loading = false);
      return;
    }

    final userId = ctrl
            .tournamentManager
            .current !=
        null
        ? ctrl
            .tournamentManager
            .current!
            .id
        : "";

    final res = await ctrl.tournamentManager.loadTopRanks(userId);
    setState(() {
      ranks = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final t = ctrl.tournamentManager.current;

    if (t == null) {
      return const Scaffold(
        body: Center(child: Text("No active tournament")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Daily Tournament")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Ends in: ${t.timeLeft.inHours}h ${t.timeLeft.inMinutes % 60}m",
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ranks.length,
                    itemBuilder: (_, i) {
                      final r = ranks[i];
                      return ListTile(
                        leading: Text("#${r.rank}"),
                        title: Text("Player ${r.userId.substring(0, 6)}"),
                        trailing: Text("${r.score}"),
                      );
                    },
                  ),
                ),
                if (ranks.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      onPressed: () async {
                        final me = ranks.last;
                        final reward =
                            await ctrl.claimTournamentReward(me.percent);
                        if (reward != null && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Reward claimed: +${reward.coins} coins"),
                            ),
                          );
                        }
                      },
                      child: const Text("CLAIM REWARD"),
                    ),
                  ),
              ],
            ),
    );
  }
}
