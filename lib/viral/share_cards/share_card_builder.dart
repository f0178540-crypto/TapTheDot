import 'share_card_payload.dart';

class ShareCardBuilder {
  ShareCardPayload build({
    required int score,
    required int bestCombo,
    required int winStreak,
    required String? cosmeticId,
    required String tag,
  }) {
    return ShareCardPayload(
      score: score,
      bestCombo: bestCombo,
      winStreak: winStreak,
      cosmeticId: cosmeticId,
      tag: tag,
    );
  }
}
