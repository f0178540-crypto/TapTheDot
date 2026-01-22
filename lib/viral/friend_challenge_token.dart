import 'dart:math';

class FriendChallengeToken {
  final String token;

  FriendChallengeToken._(this.token);

  static FriendChallengeToken generate(int score) {
    final rnd = Random();
    final salt = rnd.nextInt(99999);
    return FriendChallengeToken._('C${score}X$salt');
  }
}
