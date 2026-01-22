import 'prestige_profile.dart';

class PrestigeSystem {
  final PrestigeProfile profile;

  PrestigeSystem(this.profile);

  bool canPrestige(int playerLevel) {
    return playerLevel >= profile.nextPrestigeCost();
  }

  void doPrestige() {
    profile.prestigeLevel++;
    profile.stars += 1 + profile.prestigeLevel;
  }
}
