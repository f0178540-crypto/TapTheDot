import 'dart:ui';

class WatermarkOverlay {
  static void draw(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Tap The Dot',
        style: TextStyle(
          color: Color(0x88FFFFFF),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final pos = Offset(
      size.width - textPainter.width - 12,
      size.height - textPainter.height - 12,
    );

    textPainter.paint(canvas, pos);
  }
}
