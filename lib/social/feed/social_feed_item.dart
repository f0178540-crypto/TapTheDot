enum SocialFeedType { duelWin, duelLoss, newRecord }

class SocialFeedItem {
  final SocialFeedType type;
  final String title;
  final int score;
  final DateTime time;

  SocialFeedItem({
    required this.type,
    required this.title,
    required this.score,
    required this.time,
  });
}
