import 'event_shop_item.dart';

class EventShopManager {
  final List<EventShopItem> _items = [];

  List<EventShopItem> get items => _items;

  void setItems(List<EventShopItem> items) {
    _items
      ..clear()
      ..addAll(items);
  }

  void clear() => _items.clear();
}
