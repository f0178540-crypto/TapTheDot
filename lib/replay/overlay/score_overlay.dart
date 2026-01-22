import 'dart:ui';

class ScoreOverlay {
  static void draw(Canvas canvas, Size size, int score) {
    final paint = Paint()..color = const Color(0xAA000000);
    const padding = 12.0;

    final rect = Rect.fromLTWH(
      padding,
      padding,
      size.width * 0.5,
      48,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
      paint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'SCORE: $score',
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(padding + 12, padding + 10),
    );
  }
}
