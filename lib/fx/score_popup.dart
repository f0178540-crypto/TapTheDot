import 'package:flutter/widgets.dart';

class ScorePopup {
  Offset position = Offset.zero;
  int value = 0;
  double life = 0;

  void trigger(Offset p, int v) {
    position = p;
    value = v;
    life = 0.5; // seconds
  }

  void update(double dt) {
    if (life > 0) life -= dt;
  }

  bool get active => life > 0;
}

class ScorePopupWidget extends StatelessWidget {
  final Offset position;
  final int value;
  final double t; // 0..1 progress

  const ScorePopupWidget({
    super.key,
    required this.position,
    required this.value,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final rise = -32.0 * t;
    final scale = 0.85 + 0.35 * (1.0 - (t - 0.2).clamp(0.0, 1.0));
    final opacity = (1.0 - t).clamp(0.0, 1.0);

    return Positioned(
      left: position.dx - 18,
      top: position.dy - 24 + rise,
      child: Opacity(
        opacity: opacity,
        child: Transform.scale(
          scale: scale,
          child: Text(
            '+$value',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFFFFF),
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Color(0xCC000000),
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
