import 'event_reward.dart';

class EventRewardManager {
  final Set<String> _claimed = {};

  bool isClaimed(String id) => _claimed.contains(id);

  void markClaimed(String id) => _claimed.add(id);

  void reset() => _claimed.clear();
}
