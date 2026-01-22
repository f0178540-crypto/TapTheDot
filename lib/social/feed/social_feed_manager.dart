import 'social_feed_item.dart';

class SocialFeedManager {
  final List<SocialFeedItem> _items = [];

  List<SocialFeedItem> get items => List.unmodifiable(_items);

  void add(SocialFeedItem item) {
    _items.insert(0, item);
    if (_items.length > 30) _items.removeLast();
  }

  void clear() => _items.clear();
}
