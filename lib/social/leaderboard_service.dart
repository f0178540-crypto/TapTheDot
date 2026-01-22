import 'package:games_services/games_services.dart';

class LeaderboardService {
  static const globalId = 'CgkIxxxxxxxxEAIQAQ'; // TODO: replace in Play Console

  static Future<void> submitScore(int score) async {
    try {
      await GamesServices.submitScore(
        score: Score(
          androidLeaderboardID: globalId,
          value: score,
        ),
      );
    } catch (_) {}
  }

  static Future<void> show() async {
    try {
      await GamesServices.showLeaderboards();
    } catch (_) {}
  }
}
