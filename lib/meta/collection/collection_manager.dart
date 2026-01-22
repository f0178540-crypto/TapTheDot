import 'collectible.dart';

class CollectionManager {
  final List<Collectible> items = [
    Collectible('trail_red', 'Red Trail'),
    Collectible('trail_blue', 'Blue Trail'),
    Collectible('hit_burst_gold', 'Golden Burst'),
    Collectible('banner_neon', 'Neon Streak'),
  ];

  void unlockById(String id) {
    for (final c in items) {
      if (c.id == id) c.unlock();
    }
  }

  int get unlockedCount => items.where((c) => c.unlocked).length;
}
