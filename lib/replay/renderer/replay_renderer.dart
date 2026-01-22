import 'dart:io';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

import '../recorder/frame_buffer.dart';
import '../video/video_composer.dart';

class ReplayRenderer {
  static Future<List<File>> renderFramesWithOverlay(
    List<ReplayFrame> frames,
    int score,
  ) async {
    final dir = await getTemporaryDirectory();
    final List<File> files = [];

    for (int i = 0; i < frames.length; i++) {
      final composed =
          await VideoComposer.compose(frames[i].image, score);

      final bytes = await VideoComposer.toPng(composed);

      final f = File('${dir.path}/replay_$i.png');
      await f.writeAsBytes(bytes);
      files.add(f);
    }

    return files;
  }
}
