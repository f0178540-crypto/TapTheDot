import '../highlight_event.dart';

typedef ShareCallback = void Function(HighlightEvent event);

class ShareService {
  ShareCallback? onShare;

  void trigger(HighlightEvent event) {
    onShare?.call(event);
  }
}
