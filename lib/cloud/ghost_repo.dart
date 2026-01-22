import 'package:cloud_firestore/cloud_firestore.dart';
import '../ghost/ghost_run.dart';

class GhostRepo {
  static final _fire = FirebaseFirestore.instance;

  static Future<void> upload(String challengeId, GhostRun run) async {
    await _fire
        .collection('challenges')
        .doc(challengeId)
        .collection('ghosts')
        .doc(run.userId)
        .set(run.toMap());
  }

  static Future<GhostRun?> load(String challengeId, String userId) async {
    final doc = await _fire
        .collection('challenges')
        .doc(challengeId)
        .collection('ghosts')
        .doc(userId)
        .get();

    if (!doc.exists) return null;
    return GhostRun.fromMap(doc.data()!);
  }
}
