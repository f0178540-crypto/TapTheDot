enum GameplayModifier {
  doubleComboGain,
  extraBossHp,
  fasterPatterns,
}

class ModifierSystem {
  final Set<GameplayModifier> active = {};

  bool isActive(GameplayModifier m) => active.contains(m);

  void unlock(GameplayModifier m) {
    active.add(m);
  }

  double comboMultiplierBonus() {
    return isActive(GameplayModifier.doubleComboGain) ? 0.5 : 0.0;
  }

  double bossHpMultiplier() {
    return isActive(GameplayModifier.extraBossHp) ? 1.5 : 1.0;
  }

  double patternSpeedMultiplier() {
    return isActive(GameplayModifier.fasterPatterns) ? 1.3 : 1.0;
  }

  Map<String, dynamic> toJson() => {
        'active': active.map((e) => e.index).toList(),
      };

  void fromJson(Map<String, dynamic> json) {
    active.clear();
    final list = (json['active'] as List?) ?? [];
    for (final i in list) {
      active.add(GameplayModifier.values[i]);
    }
  }
}
