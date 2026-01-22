import '../config/economy_config.dart';

class PriceTable {
  static int revive() => EconomyConfig.reviveCost;
  static int slowMo() => EconomyConfig.slowMoCost;
  static int shield() => EconomyConfig.shieldCost;
}
