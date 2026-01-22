import 'dart:convert';
import 'challenge_payload.dart';

class ChallengeLinkCodec {
  static String encode(ChallengePayload p) {
    final map = {
      's': p.seed,
      'sc': p.score,
      'f': p.fromPlayer,
    };
    return base64UrlEncode(utf8.encode(jsonEncode(map)));
  }

  static ChallengePayload decode(String code) {
    final json =
        jsonDecode(utf8.decode(base64Url.decode(code))) as Map<String, dynamic>;

    return ChallengePayload(
      seed: json['s'],
      score: json['sc'],
      fromPlayer: json['f'],
    );
  }
}
