import 'community_challenge.dart';
import 'community_milestone.dart';

class CommunityChallengeManager {
  CommunityChallenge? active;

  void startChallenge(CommunityChallenge challenge) {
    active = challenge;
  }

  void addProgress(int v) {
    if (active == null) return;
    active!.globalProgress += v;
    if (active!.globalProgress > active!.globalTarget) {
      active!.globalProgress = active!.globalTarget;
    }
  }

  List<CommunityMilestone> getClaimableMilestones() {
    if (active == null) return [];

    return active!.milestones
        .where((m) => !m.claimed && active!.globalProgress >= m.target)
        .toList();
  }
}
