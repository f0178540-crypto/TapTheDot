import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class RewardedAdService {
  static RewardedAd? _ad;
  static bool _loading = false;

  static Future<void> init() async {
    await MobileAds.instance.initialize();
    _load();
  }

  static void _load() {
    if (_loading) return;
    _loading = true;

    RewardedAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = false;
          debugPrint("Rewarded ad loaded");
        },
        onAdFailedToLoad: (err) {
          _loading = false;
          debugPrint("Rewarded ad failed: $err");
        },
      ),
    );
  }

  static bool get isReady => _ad != null;

  static Future<bool> show() async {
    if (_ad == null) {
      _load();
      return false;
    }

    final completer = Completer<bool>();

    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        _load();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _ad = null;
        _load();
        completer.complete(false);
      },
    );

    _ad!.show(onUserEarnedReward: (_, __) {
      completer.complete(true);
    });

    return completer.future;
  }

  /// TEST IDS — replace with real ones before release
  static String get _adUnitId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "ca-app-pub-3940256099942544/5224354917";
    }
    return "";
  }
}
