import '../challenges/challenge_payload.dart';
import 'share_codec.dart';

class ShareRouter {
  ChallengePayload? route(String code) {
    final packet = ShareCodec.decode(code);

    if (packet.isChallenge) {
      return ChallengePayload(
        seed: packet.seed!,
        score: packet.score!,
        fromPlayer: packet.fromPlayer ?? 'Friend',
      );
    }

    return null;
  }
}
