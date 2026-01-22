import '../../ghost/ghost_frame.dart';

class GhostRacePayload {
  final String runId;
  final List<GhostFrame> frames;
  final int finalScore;

  GhostRacePayload({
    required this.runId,
    required this.frames,
    required this.finalScore,
  });
}
