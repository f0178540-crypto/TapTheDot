import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'tournament.dart';
import 'tournament_reward.dart';
import 'tournament_rank.dart';

class TournamentManager {
  Tournament? _current;
  Timer? _tickTimer;

  Tournament? get current => _current;

  final _fire = FirebaseFirestore.instance;

  Future<void> init() async {
    await _loadCurrent();
    _startTicker();
  }

  void dispose() {
    _tickTimer?.cancel();
  }

  // ================= LOAD CURRENT TOURNAMENT =================

  Future<void> _loadCurrent() async {
    final snap = await _fire
        .collection('tournaments')
        .orderBy('start', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return;

    final doc = snap.docs.first;
    _current = Tournament.fromMap(doc.id, doc.data());
  }

  // ================= TIMER =================

  void _startTicker() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (_current == null) {
        await _loadCurrent();
        return;
      }

      if (DateTime.now().isAfter(_current!.end)) {
        await _loadCurrent();
      }
    });
  }

  // ================= SUBMIT SCORE =================

  Future<void> submitScore({
    required String tournamentId,
    required String userId,
    required int score,
  }) async {
    await _fire
        .collection('tournaments')
        .doc(tournamentId)
        .collection('scores')
        .doc(userId)
        .set({
      'score': score,
      'ts': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ================= LEADERBOARD =================

  Future<List<TournamentRank>> loadTopRanks(String userId) async {
    if (_current == null) return [];

    final snap = await _fire
        .collection('tournaments')
        .doc(_current!.id)
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(50)
        .get();

    final allSnap = await _fire
        .collection('tournaments')
        .doc(_current!.id)
        .collection('scores')
        .orderBy('score', descending: true)
        .get();

    final total = allSnap.docs.length;

    final List<TournamentRank> ranks = [];

    for (int i = 0; i < snap.docs.length; i++) {
      final d = snap.docs[i];
      ranks.add(TournamentRank(
        userId: d.id,
        score: d['score'],
        rank: i + 1,
        totalPlayers: total,
      ));
    }

    if (!ranks.any((r) => r.userId == userId)) {
      final idx = allSnap.docs.indexWhere((d) => d.id == userId);
      if (idx != -1) {
        final d = allSnap.docs[idx];
        ranks.add(TournamentRank(
          userId: d.id,
          score: d['score'],
          rank: idx + 1,
          totalPlayers: total,
        ));
      }
    }

    return ranks;
  }

  // ================= REWARDS =================

  TournamentReward rewardForPercent(int percent) {
    if (percent <= 5) {
      return TournamentReward.big();
    } else if (percent <= 20) {
      return TournamentReward.medium();
    } else {
      return TournamentReward.small();
    }
  }
}
