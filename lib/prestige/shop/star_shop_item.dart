import '../../builds/build_path.dart';

enum StarItemType { buildUnlock, mutatorUnlock }

class StarShopItem {
  final String id;
  final StarItemType type;
  final int cost;

  final BuildPathType? build;

  const StarShopItem({
    required this.id,
    required this.type,
    required this.cost,
    this.build,
  });
}
