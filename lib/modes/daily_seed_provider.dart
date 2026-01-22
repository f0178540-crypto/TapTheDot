class DailySeedProvider {
  static int todaySeed() {
    final now = DateTime.now().toUtc();
    final key = now.year * 10000 + now.month * 100 + now.day;
    return key ^ 0x5F3759DF; // simple scramble
  }
}
