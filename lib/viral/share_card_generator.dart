import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShareCardGenerator {
  static Future<ui.Image> generate(int score) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..color = Colors.black;
    canvas.drawRect(const Rect.fromLTWH(0, 0, 600, 800), paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'I scored $score in TAP THE DOT!',
        style: const TextStyle(color: Colors.white, fontSize: 36),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: 500);
    textPainter.paint(canvas, const Offset(50, 350));

    final pic = recorder.endRecording();
    return pic.toImage(600, 800);
  }
}
