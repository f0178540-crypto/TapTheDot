class Collectible {
  final String id;
  final String name;
  bool unlocked = false;

  Collectible(this.id, this.name);

  void unlock() {
    unlocked = true;
  }
}
