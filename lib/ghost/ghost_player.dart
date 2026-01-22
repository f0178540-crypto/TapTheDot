import 'ghost_frame.dart';

class GhostPlayer {
  GhostRunPlayback? _playback;

  void load(List<GhostFrame> frames) {
    _playback = GhostRunPlayback(frames);
  }

  void reset() {
    _playback = null;
  }

  GhostFrame? sample(double time) {
    return _playback?.sample(time);
  }
}

class GhostRunPlayback {
  final List<GhostFrame> frames;

  GhostRunPlayback(this.frames);

  GhostFrame? sample(double time) {
    if (frames.isEmpty) return null;

    for (int i = 0; i < frames.length - 1; i++) {
      final a = frames[i];
      final b = frames[i + 1];

      if (time >= a.time && time <= b.time) {
        return a;
      }
    }

    return frames.last;
  }
}
