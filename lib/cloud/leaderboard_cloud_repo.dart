import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class LeaderboardCloudRepo {
  static final _db = FirebaseFirestore.instance;

  /// collection: leaderboards/{modeId}/scores/{docId}
  static CollectionReference<Map<String, dynamic>> _scoresRef(String modeId) {
    return _db.collection('leaderboards').doc(modeId).collection('scores');
  }

  /// Upload best score for user (upsert)
  static Future<void> submitScore({
    required String modeId,
    required String userId,
    required int score,
  }) async {
    try {
      final ref = _scoresRef(modeId).doc(userId);

      await _db.runTransaction((tx) async {
        final snap = await tx.get(ref);
        if (!snap.exists) {
          tx.set(ref, {
            'userId': userId,
            'score': score,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          final old = (snap.data()?['score'] ?? 0) as int;
          if (score > old) {
            tx.update(ref, {
              'score': score,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          }
        }
      });
    } catch (e) {
      debugPrint("Cloud submit score failed: $e");
      rethrow;
    }
  }

  /// Fetch global top scores
  static Future<List<Map<String, dynamic>>> fetchTop({
    required String modeId,
    int limit = 50,
  }) async {
    try {
      final q = await _scoresRef(modeId)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return q.docs.map((d) => d.data()).toList();
    } catch (e) {
      debugPrint("Cloud fetch leaderboard failed: $e");
      rethrow;
    }
  }
}
