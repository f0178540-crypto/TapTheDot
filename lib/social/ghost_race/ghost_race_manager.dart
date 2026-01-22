import 'ghost_race_payload.dart';
import '../../ghost/ghost_frame.dart';

class GhostRaceManager {
  GhostRacePayload? lastRunPayload;

  void recordRun(List<GhostFrame> frames, int score) {
    lastRunPayload = GhostRacePayload(
      runId: DateTime.now().millisecondsSinceEpoch.toString(),
      frames: List<GhostFrame>.from(frames),
      finalScore: score,
    );
  }

  GhostRacePayload? get sharableRun => lastRunPayload;
}
