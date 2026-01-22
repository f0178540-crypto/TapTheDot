enum StarPerkType {
  fasterPatterns,
  comboForgiveness,
  extraDailyBonus,
  survivalBoost,
}

class StarPerk {
  final StarPerkType type;
  final int cost;

  const StarPerk(this.type, this.cost);
}

class StarPerksCatalog {
  static const perks = <StarPerk>[
    StarPerk(StarPerkType.fasterPatterns, 5),
    StarPerk(StarPerkType.comboForgiveness, 5),
    StarPerk(StarPerkType.extraDailyBonus, 8),
    StarPerk(StarPerkType.survivalBoost, 10),
  ];
}
