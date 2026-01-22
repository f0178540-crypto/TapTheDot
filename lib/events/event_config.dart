class GameEvent {
  final String id;
  final String title;
  final double speedMultiplier;
  final double sizeMultiplier;

  const GameEvent({
    required this.id,
    required this.title,
    required this.speedMultiplier,
    required this.sizeMultiplier,
  });
}

class EventConfig {
  static const events = [
    GameEvent(
      id: 'speed_week',
      title: 'Speed Week!',
      speedMultiplier: 1.3,
      sizeMultiplier: 1.0,
    ),
    GameEvent(
      id: 'tiny_targets',
      title: 'Tiny Targets!',
      speedMultiplier: 1.0,
      sizeMultiplier: 0.75,
    ),
    GameEvent(
      id: 'double_fun',
      title: 'Double Fun!',
      speedMultiplier: 1.2,
      sizeMultiplier: 0.9,
    ),
  ];
}
