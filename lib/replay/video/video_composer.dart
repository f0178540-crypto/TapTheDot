import 'dart:ui' as ui;
import 'dart:typed_data';

import '../recorder/frame_buffer.dart';
import '../overlay/score_overlay.dart';
import '../overlay/watermark_overlay.dart';

class VideoComposer {
  static Future<ui.Image> compose(
    ui.Image base,
    int score,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    final size = ui.Size(
      base.width.toDouble(),
      base.height.toDouble(),
    );

    canvas.drawImage(base, ui.Offset.zero, ui.Paint());

    ScoreOverlay.draw(canvas, size, score);
    WatermarkOverlay.draw(canvas, size);

    final picture = recorder.endRecording();
    return picture.toImage(base.width, base.height);
  }

  static Future<Uint8List> toPng(ui.Image img) async {
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
