import 'rewarded_offer.dart';
import 'rewarded_offer_type.dart';

class RewardedOfferManager {
  bool reviveUsed = false;

  RewardedOffer? buildReviveOffer() {
    if (reviveUsed) return null;
    return RewardedOffer(
      type: RewardedOfferType.revive,
      title: 'Second Chance',
      description: 'Watch ad to revive and continue run',
    );
  }

  RewardedOffer buildDoubleCoinsOffer() {
    return RewardedOffer(
      type: RewardedOfferType.doubleCoins,
      title: 'Double Rewards',
      description: 'Watch ad to double your coins',
    );
  }

  RewardedOffer buildDailyChestOffer() {
    return RewardedOffer(
      type: RewardedOfferType.dailyChest,
      title: 'Free Chest',
      description: 'Watch ad to open daily chest',
    );
  }

  void markReviveUsed() {
    reviveUsed = true;
  }

  void resetSession() {
    reviveUsed = false;
  }
}
