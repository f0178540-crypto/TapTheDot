import 'package:shared_preferences/shared_preferences.dart';
import 'coin_wallet.dart';
import '../config/economy_config.dart';

class StoreManager {
  static const _noAdsKey = 'no_ads';
  final wallet = CoinWallet();

  Future<bool> hasNoAds() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_noAdsKey) ?? false;
  }

  Future<void> setNoAds() async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_noAdsKey, true);
  }

  Future<void> grantStarterPack() async {
    await wallet.add(EconomyConfig.starterPackCoins);
    await setNoAds();
  }

  Future<void> grantSmallCoinPack() async {
    await wallet.add(EconomyConfig.smallCoinPack);
  }
}
