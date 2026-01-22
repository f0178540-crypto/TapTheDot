import 'modifiers/event_modifier.dart';

class LiveEvent {
  final String id;
  final String name;
  final DateTime start;
  final DateTime end;
  final List<EventModifier> modifiers;

  LiveEvent({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.modifiers,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }
}
