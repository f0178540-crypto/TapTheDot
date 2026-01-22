import 'session_boost.dart';

class SessionBoostManager {
  SessionBoost? activeBoost;

  bool get hasBoost => activeBoost != null;

  void activate(SessionBoost boost) {
    activeBoost = boost;
  }

  void clear() {
    activeBoost = null;
  }
}
