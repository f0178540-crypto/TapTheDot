import 'friend_profile.dart';

class FriendLeaderboard {
  final List<FriendProfile> _friends = [];

  List<FriendProfile> get friends =>
      List.unmodifiable(_friends)..sort((a, b) => b.bestScore - a.bestScore);

  void updateFriend(String id, String name, int score) {
    final existing = _friends.where((f) => f.id == id).toList();
    if (existing.isEmpty) {
      _friends.add(FriendProfile(id: id, name: name, bestScore: score));
    } else if (score > existing.first.bestScore) {
      existing.first.bestScore = score;
    }
  }

  int? getRank(int score) {
    final sorted = friends;
    for (int i = 0; i < sorted.length; i++) {
      if (score >= sorted[i].bestScore) return i + 1;
    }
    return sorted.length + 1;
  }
}
