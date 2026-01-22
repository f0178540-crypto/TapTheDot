class PlayerProfile {
  int totalXp;
  int level;

  double speedBonus;
  double sizeBonus;
  double scoreBonus;

  PlayerProfile({
    this.totalXp = 0,
    this.level = 1,
    this.speedBonus = 0,
    this.sizeBonus = 0,
    this.scoreBonus = 0,
  });

  int get xpForNextLevel => 100 + (level * 60);

  bool addXp(int xp) {
    totalXp += xp;
    if (totalXp >= xpForNextLevel) {
      totalXp -= xpForNextLevel;
      level++;
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() => {
        'totalXp': totalXp,
        'level': level,
        'speedBonus': speedBonus,
        'sizeBonus': sizeBonus,
        'scoreBonus': scoreBonus,
      };

  static PlayerProfile fromJson(Map<String, dynamic> json) {
    return PlayerProfile(
      totalXp: json['totalXp'] ?? 0,
      level: json['level'] ?? 1,
      speedBonus: (json['speedBonus'] ?? 0).toDouble(),
      sizeBonus: (json['sizeBonus'] ?? 0).toDouble(),
      scoreBonus: (json['scoreBonus'] ?? 0).toDouble(),
    );
  }
}
