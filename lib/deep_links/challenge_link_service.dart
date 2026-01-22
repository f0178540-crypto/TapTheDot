import 'package:share_plus/share_plus.dart';

class ChallengeLinkService {
  static String buildLink(int score) {
    return 'https://tapdot.app/challenge?score=$score';
  }

  static Future<void> share(int score) async {
    final link = buildLink(score);
    await Share.share('Beat my score: $score\n$link');
  }
}
