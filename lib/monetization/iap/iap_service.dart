import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IapService {
  static final InAppPurchase _iap = InAppPurchase.instance;

  static StreamSubscription<List<PurchaseDetails>>? _sub;

  static final Set<String> productIds = {
    "coins_1000",
    "coins_5000",
    "starter_pack",
    "season_pass_premium",
  };

  static Future<bool> isAvailable() async {
    return _iap.isAvailable();
  }

  static Future<List<ProductDetails>> queryProducts() async {
    final response = await _iap.queryProductDetails(productIds);
    if (response.error != null) {
      debugPrint("IAP query error: ${response.error}");
      return [];
    }
    return response.productDetails;
  }

  static void listen(void Function(PurchaseDetails) onPurchase) {
    _sub = _iap.purchaseStream.listen((purchases) {
      for (final p in purchases) {
        onPurchase(p);
      }
    }, onError: (e) {
      debugPrint("IAP stream error: $e");
    });
  }

  static Future<void> buy(ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    await _iap.buyConsumable(purchaseParam: param, autoConsume: true);
  }

  static Future<void> complete(PurchaseDetails purchase) async {
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  static void dispose() {
    _sub?.cancel();
  }
}
