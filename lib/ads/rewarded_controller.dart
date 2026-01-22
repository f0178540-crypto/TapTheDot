import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admob_service.dart';

class RewardedController {
  RewardedAd? _ad;

  void load() {
    RewardedAd.load(
      adUnitId: AdMobService.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  Future<bool> show() async {
    final ad = _ad;
    if (ad == null) {
      load();
      return false;
    }

    final completer = Completer<bool>();
    bool rewarded = false;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _ad = null;
        load();
        completer.complete(rewarded);
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _ad = null;
        load();
        completer.complete(false);
      },
    );

    await ad.show(onUserEarnedReward: (_, __) {
      rewarded = true;
    });

    _ad = null;
    return completer.future;
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
