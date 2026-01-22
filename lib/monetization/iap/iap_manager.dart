import 'package:in_app_purchase/in_app_purchase.dart';
import 'iap_service.dart';

enum PremiumUnlock {
  none,
  seasonPass,
}

class IapManager {
  final Map<String, ProductDetails> products = {};
  PremiumUnlock premium = PremiumUnlock.none;

  Future<void> init(void Function(PurchaseDetails) onPurchase) async {
    final ok = await IapService.isAvailable();
    if (!ok) return;

    final list = await IapService.queryProducts();
    for (final p in list) {
      products[p.id] = p;
    }

    IapService.listen(onPurchase);
  }

  ProductDetails? get(String id) => products[id];
}
