class EventCountdownTimer {
  Duration? remaining;

  void update(DateTime endTime) {
    final now = DateTime.now();
    remaining = endTime.isAfter(now) ? endTime.difference(now) : Duration.zero;
  }

  String get formatted {
    if (remaining == null) return '';
    final h = remaining!.inHours;
    final m = remaining!.inMinutes % 60;
    final s = remaining!.inSeconds % 60;
    return '${h}h ${m}m ${s}s';
  }
}
