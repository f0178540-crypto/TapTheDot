class ReviveManager {
  static const int maxRevivesPerRun = 2;
  int used = 0;

  bool canRevive() => used < maxRevivesPerRun;
  void markUsed() => used++;
  void reset() => used = 0;
}
