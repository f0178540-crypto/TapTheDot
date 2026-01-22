import 'dart:ui';

class GhostTapFrame {
  final double x;
  final double y;
  final int tMs; // elapsed from round start

  const GhostTapFrame(this.x, this.y, this.tMs);

  Map<String, dynamic> toMap() => {'x': x, 'y': y, 't': tMs};

  factory GhostTapFrame.fromMap(Map<String, dynamic> m) {
    return GhostTapFrame(
      (m['x'] as num).toDouble(),
      (m['y'] as num).toDouble(),
      (m['t'] as num).toInt(),
    );
  }

  Offset get offset => Offset(x, y);
}

class GhostRecorder {
  final List<GhostTapFrame> _taps = [];
  int _startEpochMs = 0;

  bool get hasData => _taps.isNotEmpty;

  void reset() {
    _taps.clear();
    _startEpochMs = 0;
  }

  void startRound(int epochMsNow) {
    _taps.clear();
    _startEpochMs = epochMsNow;
  }

  void recordTap(Offset p, int epochMsNow) {
    if (_startEpochMs == 0) {
      // fallback: auto-start if someone forgot to call startRound
      _startEpochMs = epochMsNow;
    }
    final elapsed = epochMsNow - _startEpochMs;
    _taps.add(GhostTapFrame(p.dx, p.dy, elapsed));
  }

  List<GhostTapFrame> stop() => List.unmodifiable(_taps);
}
