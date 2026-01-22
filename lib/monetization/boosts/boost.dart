enum BoostType {
  extraTime,
  doubleScore,
  revive,
}

class Boost {
  final BoostType type;
  bool used;

  Boost(this.type, {this.used = false});
}
