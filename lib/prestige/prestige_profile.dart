class PrestigeProfile {
  int prestigeLevel = 0;
  int stars = 0;

  double globalScoreBonus() {
    return prestigeLevel * 0.05; // +5% score po prestižu
  }

  double chaosBonus() {
    return prestigeLevel * 0.04; // veća šansa za chaos faze
  }

  int nextPrestigeCost() {
    return 10 + prestigeLevel * 5; // koliko levela treba za sledeći prestiž
  }

  Map<String, dynamic> toJson() => {
        'prestigeLevel': prestigeLevel,
        'stars': stars,
      };

  void fromJson(Map<String, dynamic> m) {
    prestigeLevel = m['prestigeLevel'] ?? 0;
    stars = m['stars'] ?? 0;
  }
}
