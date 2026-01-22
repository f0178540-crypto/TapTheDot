import 'event_config.dart';

class EventManager {
  GameEvent getCurrentEvent() {
    final day = DateTime.now().weekday;
    return EventConfig.events[day % EventConfig.events.length];
  }
}
