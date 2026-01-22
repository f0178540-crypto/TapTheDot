import 'reward_tier.dart';

class RewardTrack {
  final List<RewardTier> tiers;

  RewardTrack(this.tiers);

  List<RewardTier> getAvailable(int xp) {
    return tiers
        .where((t) => !t.claimed && xp >= t.requiredXp)
        .toList();
  }
}
