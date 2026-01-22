class DifficultyManager {
  static const int startTimeMs = 1200;
  static const int minTimeMs = 380;

  static const double startRadius = 42.0;
  static const double minRadius = 14.0;

  int getTimeLimitMs(int score) {
    int t = startTimeMs - (score ~/ 3) * 90;
    if (t < minTimeMs) t = minTimeMs;
    return t;
  }

  double getRadius(int score) {
    double r = startRadius - (score ~/ 5) * 3.0;
    if (r < minRadius) r = minRadius;
    return r;
  }
}
