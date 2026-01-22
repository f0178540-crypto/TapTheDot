import 'dart:math';

class RunSeed {
  final int seed;
  late final Random rnd;

  RunSeed(this.seed) {
    rnd = Random(seed);
  }

  static RunSeed random() {
    final s = DateTime.now().millisecondsSinceEpoch & 0x7fffffff;
    return RunSeed(s);
  }

  double nextDouble() => rnd.nextDouble();

  int nextInt(int max) => rnd.nextInt(max);
}
