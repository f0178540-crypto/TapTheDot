import 'highlight_frame.dart';

class HighlightBuffer {
  final List<HighlightFrame> _frames = [];
  final double windowSeconds;

  HighlightBuffer({this.windowSeconds = 8.0});

  void clear() => _frames.clear();

  void push(HighlightFrame f) {
    _frames.add(f);
    _trim(f.t);
  }

  void _trim(double now) {
    while (_frames.isNotEmpty && now - _frames.first.t > windowSeconds) {
      _frames.removeAt(0);
    }
  }

  List<HighlightFrame> snapshot() => List.unmodifiable(_frames);
}
