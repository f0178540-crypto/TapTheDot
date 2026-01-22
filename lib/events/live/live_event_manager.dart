import 'live_event.dart';
import 'modifiers/double_score_modifier.dart';
import 'modifiers/fast_spawn_modifier.dart';

class LiveEventManager {
  final List<LiveEvent> _events = [];

  LiveEventManager() {
    // Example rotating events (can be replaced with remote config later)
    _events.add(
      LiveEvent(
        id: 'double_score_weekend',
        name: 'Double Score Weekend',
        start: DateTime.now().subtract(const Duration(hours: 2)),
        end: DateTime.now().add(const Duration(days: 2)),
        modifiers: [DoubleScoreModifier()],
      ),
    );

    _events.add(
      LiveEvent(
        id: 'speed_frenzy',
        name: 'Speed Frenzy',
        start: DateTime.now().add(const Duration(days: 3)),
        end: DateTime.now().add(const Duration(days: 5)),
        modifiers: [FastSpawnModifier()],
      ),
    );
  }

  List<LiveEvent> get activeEvents =>
      _events.where((e) => e.isActive).toList();

  bool get hasActiveEvent => activeEvents.isNotEmpty;

  List get activeModifiers =>
      activeEvents.expand((e) => e.modifiers).toList();
}
