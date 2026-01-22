import 'rewarded_offer_type.dart';

class RewardedOffer {
  final RewardedOfferType type;
  final String title;
  final String description;

  RewardedOffer({
    required this.type,
    required this.title,
    required this.description,
  });
}
