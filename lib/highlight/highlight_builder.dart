import 'highlight_buffer.dart';
import 'highlight_clip.dart';

class HighlightBuilder {
  HighlightClip build({
    required HighlightBuffer buffer,
    required int finalScore,
    required int maxCombo,
    required String tag,
  }) {
    final frames = buffer.snapshot();
    return HighlightClip(
      frames: frames,
      finalScore: finalScore,
      maxCombo: maxCombo,
      tag: tag,
    );
  }
}
