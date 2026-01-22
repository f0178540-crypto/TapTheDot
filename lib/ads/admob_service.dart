import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  // TEST IDs (safe)
  static const String appIdAndroid = 'ca-app-pub-3940256099942544~3347511713';
  static const String interstitialId = 'ca-app-pub-3940256099942544/1033173712';
  static const String rewardedId = 'ca-app-pub-3940256099942544/5224354917';

  static Future<void> init() async {
    await MobileAds.instance.initialize();
  }
}
