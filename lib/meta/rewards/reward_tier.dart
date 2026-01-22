enum RewardType {
  coins,
  collectible,
}

class RewardTier {
  final int requiredXp;
  final RewardType type;
  final int amount;
  final String? collectibleId;
  bool claimed = false;

  RewardTier.coins(this.requiredXp, this.amount)
      : type = RewardType.coins,
        collectibleId = null;

  RewardTier.collectible(this.requiredXp, this.collectibleId)
      : type = RewardType.collectible,
        amount = 0;
}
