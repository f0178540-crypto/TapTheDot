import 'package:uni_links/uni_links.dart';

class DeepLinkHandler {
  static Future<int?> getChallengeScore() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) return null;
      if (uri.queryParameters.containsKey('score')) {
        return int.tryParse(uri.queryParameters['score']!);
      }
    } catch (_) {}
    return null;
  }
}
