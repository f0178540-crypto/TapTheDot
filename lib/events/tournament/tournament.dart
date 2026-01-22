class Tournament {
  final String id;
  final String modeId;
  final DateTime start;
  final DateTime end;

  Tournament({
    required this.id,
    required this.modeId,
    required this.start,
    required this.end,
  });

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }

  Duration get timeLeft => end.difference(DateTime.now());

  factory Tournament.fromMap(String id, Map<String, dynamic> m) {
    return Tournament(
      id: id,
      modeId: m['modeId'],
      start: DateTime.fromMillisecondsSinceEpoch(m['start']),
      end: DateTime.fromMillisecondsSinceEpoch(m['end']),
    );
  }

  Map<String, dynamic> toMap() => {
        'modeId': modeId,
        'start': start.millisecondsSinceEpoch,
        'end': end.millisecondsSinceEpoch,
      };
}
