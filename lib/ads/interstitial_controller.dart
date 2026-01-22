import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admob_service.dart';

class InterstitialController {
  InterstitialAd? _ad;
  int _gameOverCount = 0;

  void load() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  void onGameOver() {
    _gameOverCount++;
    // show every 2nd game over
    if (_gameOverCount % 2 != 0) return;

    if (_ad != null) {
      _ad!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _ad = null;
          load();
        },
        onAdFailedToShowFullScreenContent: (ad, _) {
          ad.dispose();
          _ad = null;
          load();
        },
      );
      _ad!.show();
      _ad = null;
    } else {
      load();
    }
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
