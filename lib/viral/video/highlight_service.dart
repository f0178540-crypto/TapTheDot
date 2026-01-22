import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HighlightService {
  /// Move clip to temp folder and share
  static Future<void> shareVideo(String sourcePath) async {
    final src = File(sourcePath);
    if (!await src.exists()) return;

    final dir = await getTemporaryDirectory();
    final out = File('${dir.path}/tap_the_dot_highlight.mp4');

    if (await out.exists()) {
      await out.delete();
    }

    await src.copy(out.path);

    await Share.shareXFiles(
      [XFile(out.path)],
      text: "Watch my Tap The Dot highlight! 🔥 Can you beat this run?",
    );
  }
}
