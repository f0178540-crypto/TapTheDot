import 'package:in_app_purchase/in_app_purchase.dart';
import '../config/product_ids.dart';

class IapManager {
  final _iap = InAppPurchase.instance;

  Stream<List<PurchaseDetails>> get stream => _iap.purchaseStream;

  Future<void> buy(String id) async {
    final resp = await _iap.queryProductDetails({id});
    if (resp.productDetails.isEmpty) return;

    final product = resp.productDetails.first;
    final param = PurchaseParam(productDetails: product);
    await _iap.buyConsumable(purchaseParam: param, autoConsume: true);
  }

  bool isRemoveAds(PurchaseDetails p) =>
      p.productID == ProductIds.removeAds && p.status == PurchaseStatus.purchased;

  bool isStarterPack(PurchaseDetails p) =>
      p.productID == ProductIds.starterPack && p.status == PurchaseStatus.purchased;

  bool isCoinPack(PurchaseDetails p) =>
      p.productID == ProductIds.coinPackSmall && p.status == PurchaseStatus.purchased;
}
