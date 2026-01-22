import 'reward_track.dart';
import 'reward_tier.dart';

class RewardTrackManager {
  late RewardTrack track;

  RewardTrackManager() {
    track = RewardTrack([
      RewardTier.coins(100, 50),
      RewardTier.collectible(250, 'trail_red'),
      RewardTier.coins(400, 100),
      RewardTier.collectible(600, 'hit_burst_gold'),
      RewardTier.coins(900, 200),
    ]);
  }
}
