import 'dart:convert';
import 'share_packet.dart';

class ShareCodec {
  static String encode(SharePacket p) {
    final map = <String, dynamic>{};

    if (p.seed != null) map['s'] = p.seed;
    if (p.score != null) map['sc'] = p.score;
    if (p.fromPlayer != null) map['f'] = p.fromPlayer;
    if (p.tag != null) map['t'] = p.tag;

    return base64UrlEncode(utf8.encode(jsonEncode(map)));
  }

  static SharePacket decode(String code) {
    final json =
        jsonDecode(utf8.decode(base64Url.decode(code))) as Map<String, dynamic>;

    return SharePacket(
      seed: json['s'],
      score: json['sc'],
      fromPlayer: json['f'],
      tag: json['t'],
    );
  }
}
