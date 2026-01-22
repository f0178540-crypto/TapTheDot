import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ShareCardGenerator {
  static Future<Uint8List> generate({
    required int score,
    required String mode,
  }) async {
    const width = 1080;
    const height = 1920;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(const Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()));

    canvas.drawRect(
      const Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      paint,
    );

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.text = const TextSpan(
      text: "TAP THE DOT",
      style: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 4,
      ),
    );
    textPainter.layout(maxWidth: width.toDouble());
    textPainter.paint(canvas, Offset((width - textPainter.width) / 2, 180));

    textPainter.text = TextSpan(
      text: "SCORE\n$score",
      style: const TextStyle(
        fontSize: 140,
        fontWeight: FontWeight.w900,
        color: Colors.amber,
        height: 1.1,
      ),
    );
    textPainter.layout(maxWidth: width.toDouble());
    textPainter.paint(canvas, Offset((width - textPainter.width) / 2, 600));

    textPainter.text = TextSpan(
      text: "MODE: $mode",
      style: const TextStyle(
        fontSize: 48,
        color: Colors.white70,
      ),
    );
    textPainter.layout(maxWidth: width.toDouble());
    textPainter.paint(canvas, Offset((width - textPainter.width) / 2, 980));

    textPainter.text = const TextSpan(
      text: "Can you beat this?",
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
    textPainter.layout(maxWidth: width.toDouble());
    textPainter.paint(canvas, Offset((width - textPainter.width) / 2, 1250));

    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }
}
