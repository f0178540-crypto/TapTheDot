import 'star_perks.dart';
import 'star_perk_state.dart';

class StarShop {
  int stars = 0;

  final StarPerkState perks = StarPerkState();

  Future<void> load() async {
    await perks.load();
  }

  bool canBuy(StarPerk perk) {
    if (perks.has(perk.type)) return false;
    return stars >= perk.cost;
  }

  Future<bool> buy(StarPerk perk) async {
    if (!canBuy(perk)) return false;
    stars -= perk.cost;
    await perks.unlock(perk.type);
    return true;
  }

  bool hasPerk(StarPerkType type) => perks.has(type);
}
