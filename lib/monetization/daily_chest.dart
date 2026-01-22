import 'dart:math';

class DailyChest {
  DateTime? lastOpen;

  bool canOpen() {
    if (lastOpen == null) return true;
    final now = DateTime.now();
    return now.day != lastOpen!.day ||
        now.month != lastOpen!.month ||
        now.year != lastOpen!.year;
  }

  int open() {
    lastOpen = DateTime.now();
    return 100 + Random().nextInt(300); // 100–400 coins
  }
}
