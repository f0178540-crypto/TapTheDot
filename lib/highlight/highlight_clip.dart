import 'highlight_frame.dart';

class HighlightClip {
  final List<HighlightFrame> frames;
  final int finalScore;
  final int maxCombo;
  final String tag;

  HighlightClip({
    required this.frames,
    required this.finalScore,
    required this.maxCombo,
    required this.tag,
  });
}
