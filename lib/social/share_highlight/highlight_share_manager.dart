import '../../highlight/highlight_clip.dart';

class HighlightShareManager {
  HighlightClip? lastClip;

  void setClip(HighlightClip clip) {
    lastClip = clip;
  }

  bool get hasClip => lastClip != null;

  void clear() => lastClip = null;
}
