import 'community_milestone.dart';

class CommunityChallenge {
  final String id;
  final String title;
  final int globalTarget;
  int globalProgress = 0;

  final List<CommunityMilestone> milestones;

  CommunityChallenge({
    required this.id,
    required this.title,
    required this.globalTarget,
    required this.milestones,
  });

  bool get completed => globalProgress >= globalTarget;
}
